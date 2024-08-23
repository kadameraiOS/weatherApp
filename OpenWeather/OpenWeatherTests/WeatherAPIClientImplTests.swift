//
//  WeatherAPIClientImplTests.swift
//  OpenWeatherTests
//
//  Created by karthikdamera on 23/08/24.
//

import XCTest
@testable import OpenWeather

class WeatherAPIClientImplTests: XCTestCase {
    var apiClient: WeatherAPIClientImpl!
    
    override func setUp() {
        super.setUp()
        apiClient = WeatherAPIClientImpl()
    }
    
    override func tearDown() {
        apiClient = nil
        super.tearDown()
    }
    
    func testFetchWeatherByCitySuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch weather by city succeeds")
        let city = "London"
        
        // Act
        apiClient.fetchWeather(for: city) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response.name, city)
                XCTAssertGreaterThan(response.main.temp, -100) // Example check
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchWeatherByCoordinatesSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch weather by coordinates succeeds")
        let latitude: Double = 51.5074
        let longitude: Double = -0.1278
        
        // Act
        apiClient.fetchWeather(for: latitude, longitude: longitude) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
