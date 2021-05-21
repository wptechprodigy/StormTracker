//
//  RootViewModel.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import Foundation
import CoreLocation

class RootViewModel: NSObject {
    
    enum WeatherDataError: Error {
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    enum WeatherDataResult {
        case success(WeatherData)
        case failure(WeatherDataError)
    }
    
    // MARK: - Properties
    
    typealias FetchWeatherDataCompletion = (WeatherDataResult) -> Void
    
    var didFetchWeatherData: FetchWeatherDataCompletion?
    
    private let locationService: LocationService
    
    init(locationService: LocationService) {
        
        self.locationService = locationService
        
        super.init()
        
        fetchWeatherData(for: Defaults.location)
        
        fetchLocation()
    }
    
    private func fetchLocation() {
        
        locationService.fetchLocation { [weak self] result in
            
            switch result {
            case .success(let location):
                // Invoke completion handler
                self?.fetchWeatherData(for: location)
            case .failure(let locationServiceError):
                print("Unable to Fetch Location (\(locationServiceError).")
                
                // Invoke completion handler
                self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
            }

        }
        
    }
    
    private func fetchWeatherData(for location: Location) {
        
        let weatherRequest = WeatherRequest(location: location)
        
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
                
                DispatchQueue.main.async {
                    if let error = error {
                        print("Unable to Fetch Weather Data \(error)")
                        
                        let result: WeatherDataResult = .failure(.noWeatherDataAvailable)
                        
                        self?.didFetchWeatherData?(result)
                        
                    } else if let data = data {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        
                        do {
                            let darkSkyResponse = try decoder.decode(DarkSkyResponse.self, from: data)
                            
                            let result: WeatherDataResult = .success(darkSkyResponse)
                            
                            self?.didFetchWeatherData?(result)
                            
                        } catch {
                            
                            print("Unable to Decode JSON reponse \(error)")
                            
                            let result: WeatherDataResult = .failure(.noWeatherDataAvailable)
                            
                            self?.didFetchWeatherData?(result)
                            
                        }
                    } else {
                        
                        let result: WeatherDataResult = .failure(.noWeatherDataAvailable)
                        
                        self?.didFetchWeatherData?(result)
                        
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
