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
        super.tearDown()
    }
    
    func testRefresh() {
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .success(let weatherData) = result {
                print(weatherData)
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke method under test
        viewModel.refresh()
        
        //Wait for expectation to be fulfilled
        wait(for: [expectation], timeout: 2.0)
    }

}
