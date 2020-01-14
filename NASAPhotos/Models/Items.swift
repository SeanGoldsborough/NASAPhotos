//
//  Items.swift
//  NASAPhotos
//
//  Created by Sean Goldsborough on 1/8/20.
//  Copyright © 2020 Sean Goldsborough. All rights reserved.
//

import Foundation
struct Items: Codable, Hashable {
    var data: [Data2]
    var href: String
    let links : [Links]?
}
