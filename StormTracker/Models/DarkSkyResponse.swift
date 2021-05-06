//
//  DarkSkyResponse.swift
//  StormTracker
//
//  Created by waheedCodes on 06/05/2021.
//

import Foundation

struct DarkSkyResponse: Codable {
    
    // time, icon, summary, temperature, windSpeed
    struct Conditions: Codable {
        let time: Date
        let icon: String
        let summary: String
        let windSpeed: Double
        let temperature: Double
    }
    
    struct Daily: Codable {
        let data: [Conditions]
        
        struct Conditions: Codable {
            let time: Date
            let icon: String
            let windSpeed: Double
            let temperatureMin: Double
            let temperatureMax: Double
        }
    }
    
    let latitude: Double
    let longitude: Double
    
    let currently: Conditions
    let daily: Daily
    
}
