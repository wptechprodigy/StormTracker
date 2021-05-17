//
//  WeekDayViewModelTests.swift
//  StormTrackerTests
//
//  Created by waheedCodes on 17/05/2021.
//

import XCTest
@testable import StormTracker

class WeekDayViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: WeekDayViewModel!
    
    // MARK: - Set up and Tear down
    
    override func setUp() {
        super.setUp()
        
        let data = loadStub(name: "DarkSky", extension: "json")
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .secondsSince1970
        let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self,
                                                  from: data)
        
        viewModel = WeekDayViewModel(weatherData: darkSkyResponse.forecast[5])
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testDay() {
        XCTAssertEqual(viewModel.day, "Monday")
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "May 10")
    }
    
    func testTemperature() {
        XCTAssertEqual(viewModel.temperature, "23.3 ºF - 31.6 ºF")
    }
    
    func testWinsSpeed() {
        XCTAssertEqual(viewModel.windSpeed, "2 MPH")
    }
    
    func testImage() {
        let viewModelImage = viewModel.image
        let imageDataViewModel = UIImage.pngData(viewModelImage!)() // imageDataViewModel
        let imageDataReference = UIImage.pngData(UIImage(named: "clear-day")!)() // imageDataReference
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 48.0)
        XCTAssertEqual(viewModelImage!.size.height, 48.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }

}
