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

enum LocationServiceResult {
    case success(Location)
    case failure(LocationServiceError)
}

protocol LocationService {
    
    // MARK: - Type Alias
    
    typealias FetchLocationCompletion = (LocationServiceResult) -> Void
    
    // MARK: - Helper Methods
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
}
