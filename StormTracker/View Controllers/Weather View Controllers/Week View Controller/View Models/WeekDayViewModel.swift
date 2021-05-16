//
//  WeekDayViewModel.swift
//  StormTracker
//
//  Created by waheedCodes on 14/05/2021.
//

import UIKit

struct WeekDayViewModel {
    
    // MARK: - Properties
    
    let weatherData: ForecastWeatherConditions
    
    private static let dateFormatter = DateFormatter()
    
    var day: String {
        WeekDayViewModel.dateFormatter.dateFormat = "EEEE"
        
        return WeekDayViewModel.dateFormatter.string(from: weatherData.time)
    }
    
    var date: String {
        WeekDayViewModel.dateFormatter.dateFormat = "MMMM d"
        
        return WeekDayViewModel.dateFormatter.string(from: weatherData.time)
    }
    
    var temperature: String {
        let min = String(format: "%.1f ºF", weatherData.temperatureMin)
        let max = String(format: "%.1f ºF", weatherData.temperatureMax)
        
        return "\(min) - \(max)"
    }
    
    var windSpeed: String {
        return String(format: "%.f MPH", weatherData.windSpeed)
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(with: weatherData.icon)
    }
}

extension WeekDayViewModel: WeekDayRepresentable {
    
}
