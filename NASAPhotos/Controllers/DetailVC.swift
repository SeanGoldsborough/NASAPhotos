//
//  DetailVC.swift
//  NASAPhotos
//
//  Created by Sean Goldsborough on 1/8/20.
//  Copyright © 2020 Sean Goldsborough. All rights reserved.
//

import Foundation
import UIKit

class DetailVC: UIViewController {
    //var items = [Items]()
    var item: Items?
    var imageUrl = ""
    var navTitle = ""
    var indexNumber = 3
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var photoCreditLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true

        performUpdatesOnMain {
            var urlString = self.item?.links![0].href
            urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            self.configImage(url: urlString ?? (self.item?.links![0].href!)!)
            self.titleLabel.text = self.item?.data[0].title ?? "N/A"
            self.descriptionTextView.text = self.item?.data[0].description ?? "N/A"
            self.photoCreditLabel.text = self.item?.data[0].center ?? "N/A"
            self.locationLabel.text = self.item?.data[0].location ?? "N/A"
        }
    }

    private func configImage(url: String) {
        var imageUrl = url ?? "https://images-assets.nasa.gov/image/PIA01717/PIA01717~thumb.jpg"
        imageUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        NetworkManager.shared.getImage(urlString: imageUrl, completed: { (data, error) in
            if let error = error {
                performUpdatesOnMain {
                    AlertView.alertPopUp(view: self, alertMessage: "Error: \(error.localizedDescription)")
                }
                return
            } else if let data = data {
                performUpdatesOnMain {
                    if let currentCell = self.imageView {
                        if imageUrl == imageUrl {
                            currentCell.image = UIImage(data: data as Data)
                        }
                    }
                }
            }
        })
    }
}
