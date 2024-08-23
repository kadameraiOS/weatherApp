//
//  WeatherRepositoryImplTests.swift
//  OpenWeatherTests
//
//  Created by karthikdamera on 23/08/24.
//

import XCTest
@testable import OpenWeather

class WeatherRepositoryImplTests: XCTestCase {
    var repository: WeatherRepositoryImpl!
    var apiClientMock: WeatherAPIClientMock!
    
    override func setUp() {
        super.setUp()
        apiClientMock = WeatherAPIClientMock()
        repository = WeatherRepositoryImpl(apiClient: apiClientMock)
    }
    
    override func tearDown() {
        repository = nil
        apiClientMock = nil
        super.tearDown()
    }
    
    func testGetWeatherByCity() {
        // Arrange
        let expectation = XCTestExpectation(description: "Get weather by city succeeds")
        let city = "London"
        let mockResponse = WeatherResponse(main: .init(temp: 15.0), weather: [.init(description: "Clear", icon: "01d")], name: city)
        apiClientMock.mockResponse = .success(mockResponse)
        
        // Act
        repository.getWeather(for: city) { result in
            switch result {
            case .success(let weather):
                XCTAssertEqual(weather.temperature, 15.0)
                XCTAssertEqual(weather.iconCode, "01d")
                XCTAssertEqual(weather.cityName, city)
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetWeatherByCoordinates() {
        // Arrange
        let expectation = XCTestExpectation(description: "Get weather by coordinates succeeds")
        let latitude: Double = 51.5074
        let longitude: Double = -0.1278
        let mockResponse = WeatherResponse(main: .init(temp: 15.0), weather: [.init(description: "Clear", icon: "01d")], name: "London")
        apiClientMock.mockResponse = .success(mockResponse)
        
        // Act
        repository.getWeather(for: latitude, longitude: longitude) { result in
            switch result {
            case .success(let weather):
                XCTAssertEqual(weather.temperature, 15.0)
                XCTAssertEqual(weather.iconCode, "01d")
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}

class WeatherAPIClientMock: WeatherAPIClient {
    var mockResponse: Result<WeatherResponse, Error>!
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        completion(mockResponse)
    }
    
    func fetchWeather(for latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        completion(mockResponse)
    }
}
