//
//  Collection.swift
//  NASAPhotos
//
//  Created by Sean Goldsborough on 1/8/20.
//  Copyright © 2020 Sean Goldsborough. All rights reserved.
//

import Foundation
struct PhotoCollection : Codable, Hashable {
    let links : [Links]?
    let version : String?
    let items : [Items]?
    let href : String?
}
