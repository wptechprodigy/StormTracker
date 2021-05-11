//
//  DayViewModel.swift
//  StormTracker
//
//  Created by waheedCodes on 10/05/2021.
//

import UIKit

struct DayViewModel {
    
    // MARK: - Properties
    
    var weatherData: CurrentWeatherConditions
    
    // MARK: - Helper Methods
    
    private static let dateFormatter = DateFormatter()
    
    var date: String {
        DayViewModel.dateFormatter.dateFormat = "EEE, MMMM d YYYY"
        return DayViewModel.dateFormatter.string(from: weatherData.time)
    }
    
    var time: String {
        DayViewModel.dateFormatter.dateFormat = "hh:mm a"
        return DayViewModel.dateFormatter.string(from: weatherData.time)
    }
    
    var summary: String {
        return weatherData.summary
    }
    
    var temperature: String {
        return String(format: "%.1f ºF", weatherData.temperature)
    }
    
    var windSpeed: String {
        return String(format: "%.f MPH", weatherData.windSpeed)
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(with: weatherData.icon)
    }
}
