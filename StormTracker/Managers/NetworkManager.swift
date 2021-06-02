//
//  NetworkManager.swift
//  StormTracker
//
//  Created by waheedCodes on 28/05/2021.
//

import Foundation

class NetworkManager: NetworkService {
    
    // MARK:- Network Service
    
    func fetchData(with request: URLRequest, completionHandler: @escaping FetchDataCompletion) {
        urlSession.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    private let urlSession = URLSession(configuration: .default)

}
