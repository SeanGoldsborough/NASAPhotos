//
//  Data.swift
//  NASAPhotos
//
//  Created by Sean Goldsborough on 1/8/20.
//  Copyright © 2020 Sean Goldsborough. All rights reserved.
//

import Foundation
struct Data2 : Codable, Hashable {
    let media_type : String?
    let keywords : [String]?
    let secondary_creator : String?
    let description_508 : String?
    let date_created : String?
    let nasa_id : String?
    let center : String?
    let title : String?
    let description : String?
    let location : String?

    enum CodingKeys: String, CodingKey {

        case media_type = "media_type"
        case keywords = "keywords"
        case secondary_creator = "secondary_creator"
        case description_508 = "description_508"
        case date_created = "date_created"
        case nasa_id = "nasa_id"
        case center = "center"
        case title = "title"
        case description = "description"
        case location = "location"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
        keywords = try values.decodeIfPresent([String].self, forKey: .keywords)
        secondary_creator = try values.decodeIfPresent(String.self, forKey: .secondary_creator)
        description_508 = try values.decodeIfPresent(String.self, forKey: .description_508)
        date_created = try values.decodeIfPresent(String.self, forKey: .date_created)
        nasa_id = try values.decodeIfPresent(String.self, forKey: .nasa_id)
        center = try values.decodeIfPresent(String.self, forKey: .center)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        location = try values.decodeIfPresent(String.self, forKey: .location)
    }

}
