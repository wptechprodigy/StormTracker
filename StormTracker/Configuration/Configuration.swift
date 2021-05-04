//
//  Configuration.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import Foundation
import CoreLocation

enum Defaults {
    
    static let location = CLLocation(latitude: 6.5833, longitude: 3.75)
    
}

enum WeatherService {
    
    private static let xRapidApiKey = "ded85e4952msh264ae91e0e7722ep1b82c8jsn890ef2c21b29"
    private static let xRapidHost = "dark-sky.p.rapidapi.com"
    
    static let headers: [String: String] = [
        "x-rapidapi-key": xRapidApiKey,
        "x-rapidapi-host": xRapidHost
    ]
    
}
