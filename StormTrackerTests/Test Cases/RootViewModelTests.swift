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
    var networkService: MockNetworkService!
    var locationService: MockLocationService!
    
    // MARK: - Setup and Tear down

    override func setUp() {
        
        super.setUp()
        
        // Initialize Mock Network Service
        networkService = MockNetworkService()
        
        // Initialize Mock Location Service
        locationService = MockLocationService()
        
        // Configure Mock Network Service\
        networkService.data = loadStub(name: "DarkSky", extension: "json")
        
        // Initialize Root View Model
        viewModel = RootViewModel(networkService: networkService, locationService: locationService)
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
                
                XCTAssertEqual(weatherData.latitude, 6.5833)
                XCTAssertEqual(weatherData.longitude, 3.75)
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke method under test
        viewModel.refresh()
        
        //Wait for expectation to be fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_FailedToFetchLocation() {
        // Simulate a failed location
        locationService.location = nil
        
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Location")
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, RootViewModel.WeatherDataError.notAuthorizedToRequestLocation)
                
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke method under test
        viewModel.refresh()
        
        //Wait for expectation to be fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_FailedToFetchWeatherData_RequestFailed() {
        // Simulate failed Weather Data
        networkService.error = NSError(domain: "com.waheedcodes.network.service", code: 1, userInfo: nil)
        
        // Define Expectation
        let expectation = XCTestExpectation(description: "Request Weather Data Failed")
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                
                XCTAssertEqual(error, RootViewModel.WeatherDataError.noWeatherDataAvailable)
                
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
