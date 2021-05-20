//
//  LocationService.swift
//  StormTracker
//
//  Created by waheedCodes on 20/05/2021.
//

import Foundation

protocol LocationService {
    
    // MARK: - Type Alias
    
    typealias FetchLocationCompletion = (Location?, Error?) -> Void
    
    // MARK: - Helper Methods
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
}
