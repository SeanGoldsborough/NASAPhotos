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
}
