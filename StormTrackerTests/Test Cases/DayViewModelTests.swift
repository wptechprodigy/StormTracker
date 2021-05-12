//
//  DayViewModelTests.swift
//  StormTrackerTests
//
//  Created by waheedCodes on 12/05/2021.
//

import XCTest
@testable import StormTracker

class DayViewModelTests: XCTestCase {
    
    var viewModel: DayViewModel!

    override func setUp() {
        super.setUp()
        
        let data = loadStub(name: "DarkSky", extension: "json")
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .secondsSince1970
        let darkSKyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        viewModel = DayViewModel(weatherData: darkSKyResponse.current)
    }

    override func tearDown() {
        
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "Wed, May 5 2021")
    }
    
    func testTime() {
        XCTAssertEqual(viewModel.time, "04:50 PM")
    }
    
    func testTemperature() {
        XCTAssertEqual(viewModel.temperature, "30.6 ºF")
    }
    
    func testWinsSpeed() {
        XCTAssertEqual(viewModel.windSpeed, "4 MPH")
    }
    
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Humid and Overcast")
    }
    
    func testImage() {
        let viewModelImage = viewModel.image
        let _ = UIImage.pngData(viewModelImage!) // imageDataViewModel
        let _ = UIImage.pngData(UIImage(named: "cloudy")!) // imageDataReference
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 48.0)
        XCTAssertEqual(viewModelImage!.size.height, 48.0)
    }

}
