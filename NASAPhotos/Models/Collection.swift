//
//  Collection.swift
//  NASAPhotos
//
//  Created by Sean Goldsborough on 1/8/20.
//  Copyright © 2020 Sean Goldsborough. All rights reserved.
//

import Foundation
struct PhotoCollection : Codable, Hashable {
    //let links : [Links]?
    let version : String?
    let items : [Items]?
    let href : String?
   // let metadata : Metadata?

    enum CodingKeys: String, CodingKey {

       // case links = "links"
        case version = "version"
        case items = "items"
        case href = "href"
      //  case metadata = "metadata"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       // links = try values.decodeIfPresent([Links].self, forKey: .links)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
        href = try values.decodeIfPresent(String.self, forKey: .href)
       // metadata = try values.decodeIfPresent(Metadata.self, forKey: .metadata)
    }

}
