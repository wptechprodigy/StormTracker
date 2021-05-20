//
//  WeatherRequest.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import Foundation
import CoreLocation

struct WeatherRequest {
    
    var baseURL: String {
        return "https://dark-sky.p.rapidapi.com/"
    }
    
    let location: CLLocation
    
    private var longitude: Double {
        return location.coordinate.longitude
    }
    
    private var latitude: Double {
        return location.coordinate.latitude
    }
    
    var baseURLWithLocation: String {
        return baseURL + "\(latitude),\(longitude)?lang=en"
    }
}
