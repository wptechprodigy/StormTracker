//
//  RootViewModel.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import UIKit
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
    
    private let networkService: NetworkService
    private let locationService: LocationService
    
    // MARK: - Initialization
    
    init(networkService: NetworkService, locationService: LocationService) {
        // Set Services
        self.networkService = networkService
        self.locationService = locationService
        
        super.init()
        
        setupNotificationHandling()

    }
    
    // MARK: - Helper Methods
    
    private func fetchLocation() {
        
        locationService.fetchLocation { [weak self] (result) in
            
            switch result {
            case .success(let location):
                // Invoke completion handler
                self?.fetchWeatherData(for: location)
            case .failure(let locationServiceError):
                print("Unable to Fetch Location (\(locationServiceError).")
                
                // Weather data result
                let result: WeatherDataResult = .failure(.notAuthorizedToRequestLocation)
                
                // Invoke completion handler
                self?.didFetchWeatherData?(result)
            }

        }
        
    }
    
    private func setupNotificationHandling() {
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification,
                                               object: nil,
                                               queue: OperationQueue.main) { [weak self] (_) in
            guard let didFetchWeatherData = UserDefaults.didFetchWeatherData else {
                self?.refresh()
                return
            }
            
            if Date().timeIntervalSince(didFetchWeatherData) > Configuration.refreshThreshold {
                self?.refresh()
            }
            
        }
    }
    
    func refresh() {
        fetchLocation()
    }
    
    private func fetchWeatherData(for location: Location) {
        
        let weatherRequest = WeatherRequest(location: location)
        
        let request = NSMutableURLRequest(url: NSURL(string: weatherRequest.baseURLWithLocation)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: Request.Timeout.interval)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = WeatherService.headers
        
        networkService.fetchData(
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
                            
                            // Update the userdefault with the time the data was fetched
                            UserDefaults.didFetchWeatherData = Date()
                            
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
        
    }
}

extension RootViewModel {
    fileprivate enum Request {
        enum Timeout {
            static let interval: Double = 10.0
        }
    }
}

extension UserDefaults {
    
    // MARK: - Types
    
    private enum Keys {
        static let didFetchWeatherData = "didFetchWeatherData"
    }
    
    // MARK: - Class computed properties
    
    fileprivate class var didFetchWeatherData: Date? {
        get {
            return UserDefaults.standard.object(forKey: Keys.didFetchWeatherData) as? Date
        }
        
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.didFetchWeatherData)
        }
    }
    
}
