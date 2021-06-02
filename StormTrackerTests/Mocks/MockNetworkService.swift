//
//  MockNetworkService.swift
//  StormTrackerTests
//
//  Created by waheedCodes on 28/05/2021.
//

import Foundation
@testable import StormTracker

class MockNetworkService: NetworkService {
    
    // MARK: - Properties
    
    var data: Data?
    var error: Error?
    var statusCode: Int = 200
    
    // MARK: - Network Service
    
    func fetchData(with request: URLRequest, completionHandler: @escaping NetworkService.FetchDataCompletion) {
        
        // Invoke Handler
        completionHandler(data, URLResponse(), error)
        
    }
}
