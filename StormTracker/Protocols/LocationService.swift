//
//  LocationService.swift
//  StormTracker
//
//  Created by waheedCodes on 20/05/2021.
//

import Foundation

enum LocationServiceError: Error {
    case notAuthorizedToRequestLocation
}

protocol LocationService {
    
    // MARK: - Type Alias
    
    typealias FetchLocationCompletion = (Location?, LocationServiceError?) -> Void
    
    // MARK: - Helper Methods
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
}
