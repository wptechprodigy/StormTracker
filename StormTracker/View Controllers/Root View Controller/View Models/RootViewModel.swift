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
        case noWeatherDataAvailable
    }
    
    // MARK: - Properties
    
    typealias DidFetchWeatherDataCompletion = (WeatherData?, WeatherDataError?) -> Void
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    private lazy var locationManager: CLLocationManager = {
        
        let locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        return locationManager
    }()
    
    override init() {
        super.init()
        
        fetchWeatherData(for: Defaults.location)
        
        fetchLocation()
    }
    
    private func fetchLocation() {
        locationManager.requestLocation()
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
                
                if let error = error {
                    DispatchQueue.main.async {
                        print("Unable to Fetch Weather Data \(error)")
                        self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                    }
                } else if let data = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
                    do {
                        let darkSkyResponse = try decoder.decode(DarkSkyResponse.self, from: data)
                        DispatchQueue.main.async {
                            self?.didFetchWeatherData?(darkSkyResponse, nil)
                        }
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

extension RootViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Checking location access...
        switch manager.authorizationStatus {
        case .notDetermined:
            // Request Authorization
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            fetchLocation()
        default:
            didFetchWeatherData?(nil, .notAuthorizedToRequestLocation)
        }
    }
    
    // Locations updated?
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // Fetch weather data with the device location
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let userLocation = Location(latitude: latitude, longitude: longitude)
        
        fetchWeatherData(for: userLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to Fetch Location (\(error))")
    }
    
}
