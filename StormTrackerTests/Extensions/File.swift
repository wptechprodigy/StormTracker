//
//  File.swift
//  StormTrackerTests
//
//  Created by waheedCodes on 12/05/2021.
//

import XCTest

extension XCTest {
    
    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        return try! Data(contentsOf: url!)
    }
    
}
