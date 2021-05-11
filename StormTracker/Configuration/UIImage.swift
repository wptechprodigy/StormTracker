//
//  UIImage.swift
//  StormTracker
//
//  Created by waheedCodes on 11/05/2021.
//

import UIKit

extension UIImage {
    
    class func imageForIcon(with name: String) -> UIImage? {
        
        switch name {
        case "clear-day",
             "clear-night",
             "fog",
             "rain",
             "snow",
             "sleet",
             "wind":
            return UIImage(named: name)
        case "partly-clear-day",
             "partly-clear-night":
            return UIImage(named: "cloudy")
        default:
            return UIImage(named: "clear-day")
        }
        
    }
}
