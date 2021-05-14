//
//  WeekViewModel.swift
//  StormTracker
//
//  Created by waheedCodes on 10/05/2021.
//

import Foundation

struct WeekViewModel {
    
    // MARK: - Properties
    
    var weatherData: [ForecastWeatherConditions]
    
    // MARK: -
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
}
