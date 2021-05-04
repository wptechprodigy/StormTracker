//
//  Configuration.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import Foundation

enum Defaults {
    
    static let longitude: Double = 3.75
    static let latitude: Double = 6.5833
    
}

enum WeatherService {
    
    private static let xRapidApiKey = "ded85e4952msh264ae91e0e7722ep1b82c8jsn890ef2c21b29"
    private static let xRapidHost = "dark-sky.p.rapidapi.com"
    
    static let headers: [String: String] = [
        "x-rapidapi-key": xRapidApiKey,
        "x-rapidapi-host": xRapidHost
    ]
    
}
