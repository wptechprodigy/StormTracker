//
//  RootViewModel.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import Foundation

class RootViewModel {
    
    // MARK: - Properties
    
    typealias DidFetchWeatherDataCompletion = (Data?, Error?) -> Void
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    init() {
        fetchWeatherData()
    }
    
    private func fetchWeatherData() {
        
        let weatherRequest = WeatherRequest(location: Defaults.location)
        
        let request = NSMutableURLRequest(url: NSURL(string: weatherRequest.baseURLWithLocation)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: Request.Timeout.interval)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = WeatherService.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest,
                                        completionHandler: { [weak self] (data, response, error) -> Void in
                                            if let error = error {
                                                self?.didFetchWeatherData?(nil, error)
                                            } else if let data = data {
                                                self?.didFetchWeatherData?(data, nil)
                                            } else {
                                                self?.didFetchWeatherData?(nil, nil)
                                            }
                                        })
        
        dataTask.resume()
        
    }
}

extension RootViewModel {
    fileprivate enum Request {
        enum Timeout {
            static let interval: Double = 10.0
        }
    }
}
