//
//  RootViewModel.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import Foundation

class RootViewModel {
    
    enum WeatherDataError: Error {
        case noWeatherDataAvailable
    }
    
    // MARK: - Properties
    
    typealias DidFetchWeatherDataCompletion = (WeatherData?, WeatherDataError?) -> Void
    
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
        let dataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { [weak self] (data, response, error) -> Void in
                if let response = response as? HTTPURLResponse {
                    print("Status code: \(response.statusCode)")
                }
                
                if let error = error {
                    DispatchQueue.main.async {
                        print("Unable to Fetch Weather Data \(error)")
                        self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                    }
                } else if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let darkSkyResponse = try decoder.decode(DarkSkyResponse.self, from: data)
                        
                        self?.didFetchWeatherData?(darkSkyResponse, nil)
                    } catch {
                        DispatchQueue.main.async {
                            print("Unable to Decode JSON reponse \(error)")
                            self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                    }
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
