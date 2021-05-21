//
//  LocationManager.swift
//  StormTracker
//
//  Created by waheedCodes on 20/05/2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, LocationService {
    
    // MARK: - Properties
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private var didFetchLocation: FetchLocationCompletion?
    
    // MARK: - LocationService methods
    
    func fetchLocation(completion: @escaping FetchLocationCompletion) {
        // Store reference to completion
        self.didFetchLocation = completion
        
        // Fetch Location
        locationManager.requestLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Checking location access...
        switch manager.authorizationStatus {
        case .notDetermined:
            // Request Authorization
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        default:
            // Invoke the completion handler
            didFetchLocation?(.failure(.notAuthorizedToRequestLocation))
            
            // Reset the completion handler
            didFetchLocation = nil
        }
    }
    
    // Locations updated?
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // Invoke the completion handler
        didFetchLocation?(.success(Location(location: location)))
        
        // Reset Completion Handler
        didFetchLocation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to Fetch Location (\(error))")
    }
    
}

/// Can only be accessed within the LocationManager
fileprivate extension Location {
    
    // MARK: - Initialization
    
    init(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
    
}
