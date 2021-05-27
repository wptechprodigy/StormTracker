//
//  RootViewModelTests.swift
//  StormTrackerTests
//
//  Created by waheedCodes on 27/05/2021.
//

import XCTest
@testable import StormTracker

class RootViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: RootViewModel!
    
    // MARK: - Setup and Tear down

    override func setUp() {
        
        super.setUp()
        
        
        viewModel = RootViewModel(locationService: MockLocationService())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
