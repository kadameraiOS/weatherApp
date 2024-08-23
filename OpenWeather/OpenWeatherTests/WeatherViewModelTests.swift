//
//  WeatherViewModelTests.swift
//  OpenWeatherTests
//
//  Created by karthikdamera on 23/08/24.
//
import XCTest
@testable import OpenWeather

class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var repositoryMock: WeatherRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repositoryMock = WeatherRepositoryMock()
        viewModel = WeatherViewModel(getWeatherUseCase: GetWeatherUseCaseImpl(repository: repositoryMock))
    }
    
    override func tearDown() {
        viewModel = nil
        repositoryMock = nil
        super.tearDown()
    }
    
    func testFetchWeatherForLocation() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch weather for location succeeds")
        let mockWeather = Weather(temperature: 15.0, condition: "Clear", cityName: "London", iconCode: "01d")
        repositoryMock.mockWeather = mockWeather
        
        // Act
        viewModel.fetchWeatherForCity()
        
        expectation.fulfill()
    }
}

class WeatherRepositoryMock: WeatherRepository {
    var mockWeather: Weather!
    
    func getWeather(for city: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        completion(.success(mockWeather))
    }
    
    func getWeather(for latitude: Double, longitude: Double, completion: @escaping (Result<Weather, Error>) -> Void) {
        completion(.success(mockWeather))
    }
}
