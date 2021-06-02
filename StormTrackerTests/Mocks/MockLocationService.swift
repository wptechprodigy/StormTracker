//
//  MockLocationService.swift
//  StormTrackerTests
//
//  Created by waheedCodes on 27/05/2021.
//

import Foundation
@testable import StormTracker

class MockLocationService: LocationService {
    
    // MARK: - Properties
    
    var location: Location? = Location(latitude: 0.0, longitude: 0.0)
    var delay: TimeInterval = 0.0
    
    func fetchLocation(completion: @escaping FetchLocationCompletion) {
        let result: LocationServiceResult
        
        if let location = location {
            result = .success(location)
        } else {
            result = .failure(.notAuthorizedToRequestLocation)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion(result)
        }
    }
    
}
