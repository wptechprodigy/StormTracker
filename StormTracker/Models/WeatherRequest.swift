//
//  WeatherRequest.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import Foundation

struct WeatherRequest {
    
    private var baseURL: String {
        return "https://dark-sky.p.rapidapi.com/"
    }
    
    let location: Location
    
    private var longitude: Double {
        return location.longitude
    }
    
    private var latitude: Double {
        return location.latitude
    }
    
    var baseURLWithLocation: String {
        return baseURL + "\(latitude),\(longitude)?lang=en"
    }
}
