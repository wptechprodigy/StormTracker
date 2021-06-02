//
//  NetworkService.swift
//  StormTracker
//
//  Created by waheedCodes on 28/05/2021.
//

import Foundation

protocol NetworkService {
    
    // MARK: - Type Alias
    
    typealias FetchDataCompletion = (Data?, URLResponse?, Error?) -> Void
    
    // MARK: - Helper Methods
    
    func fetchData(with request: URLRequest, completionHandler: @escaping FetchDataCompletion)
}
