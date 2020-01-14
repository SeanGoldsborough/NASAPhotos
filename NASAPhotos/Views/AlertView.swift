//
//  AlertView.swift
//  NASAPhotos
//
//  Created by Sean Goldsborough on 1/13/20.
//  Copyright © 2020 Sean Goldsborough. All rights reserved.
//

import Foundation
import UIKit

class AlertView {
    
    class func alertPopUp(view: UIViewController, alertMessage: String) {
        let alert = UIAlertController(title: "ERROR", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler:  { action in
            print("make a call to get image")
        }))
        
        performUpdatesOnMain {
            view.present(alert, animated: true, completion: nil)
        }
    }
}

