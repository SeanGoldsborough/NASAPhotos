//
//  Base.swift
//  NASAPhotos
//
//  Created by Sean Goldsborough on 1/8/20.
//  Copyright © 2020 Sean Goldsborough. All rights reserved.
//

import Foundation

struct Base : Codable, Hashable {
    let collection: PhotoCollection?
    
    enum CodingKeys: String, CodingKey {
        case collection = "collection"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        collection = try values.decodeIfPresent(PhotoCollection.self, forKey: .collection)
    }
}
