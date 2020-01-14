//
//  ErrorMessages.swift
//  NASAPhotos
//
//  Created by Sean Goldsborough on 1/8/20.
//  Copyright © 2020 Sean Goldsborough. All rights reserved.
//

import Foundation

enum CustomError: String, Error {
    case badConnection = "Unable to complete your request"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "No data was received from the server. Please try again."
    case invalidData = "The data received from the server was invalid."
}
