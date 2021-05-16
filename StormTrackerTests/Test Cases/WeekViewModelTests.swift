//
//  WeekViewModelTests.swift
//  StormTrackerTests
//
//  Created by waheedCodes on 16/05/2021.
//

import XCTest
@testable import StormTracker

class WeekViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: WeekViewModel!
    
    // MARK: - Setup and Tear down

    override func setUp() {
        super.setUp()
        
        let data = loadStub(name: "DarkSky", extension: "json")
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .secondsSince1970
        let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self,
                                                  from: data)
        viewModel = WeekViewModel(weatherData: darkSkyResponse.forecast)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test for number of days
    
    func testNumberOfDays() {
        XCTAssertEqual(viewModel.numberOfDays, 8)
    }
    
    // MARK: - Test view model for index
    
    func testViewModelForIndex() {
        let weekDayViewModel = viewModel.viewModel(for: 5)
        
        XCTAssertEqual(weekDayViewModel.day, "Monday")
        XCTAssertEqual(weekDayViewModel.date, "May 10")
    }

}
