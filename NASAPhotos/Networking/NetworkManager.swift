//
//  NetworkManager.swift
//  NASAPhotos
//
//  Created by Sean Goldsborough on 1/8/20.
//  Copyright © 2020 Sean Goldsborough. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    let baseURL = "https://images-api.nasa.gov"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}    
    
    func getItemsData(page: Int, completed: @escaping (Result<[Items], CustomError>) -> Void) {
       
        var parameters = ["q": "images", "page" : "\(page)"]
        var endpoint = NetworkManager.shared.URLFromParameters(parameters as [String : AnyObject])
        let request = URLRequest(url: endpoint, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let photoItems = try decoder.decode(Base.self, from: data)
                completed(.success(((photoItems.collection?.items)!)))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getImage(urlString: String, completed: @escaping (_ results: Data?,_ error:NSError?) -> ()){
        do{
            var encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            var url = URL(string: encodedURLString!)

            let imageData = try Data(contentsOf: url!)
            completed(imageData,nil)
        }
        catch let error as NSError {
            completed(nil,error)
        }
    }
}
