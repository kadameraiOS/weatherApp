//
//  WeatherRepositoryImpl.swift
//  OpenWeather
//
//  Created by karthikdamera on 23/08/24.
//

import Foundation

class WeatherRepositoryImpl: WeatherRepository {
    private let apiClient: WeatherAPIClient
    
    init(apiClient: WeatherAPIClient) {
        self.apiClient = apiClient
    }
    
    func getWeather(for city: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        apiClient.fetchWeather(for: city) { result in
            switch result {
            case .success(let response):
                let weather = Weather(
                    temperature: response.main.temp,
                    condition: response.weather.first?.description ?? "",
                    cityName: response.name,
                    iconCode: response.weather.first?.icon ?? ""
                )
                completion(.success(weather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getWeather(for latitude: Double, longitude: Double, completion: @escaping (Result<Weather, Error>) -> Void) {
        apiClient.fetchWeather(for: latitude, longitude: longitude) { result in
            switch result {
            case .success(let response):
                let weather = Weather(
                    temperature: response.main.temp,
                    condition: response.weather.first?.description ?? "",
                    cityName: response.name,
                    iconCode: response.weather.first?.icon ?? ""
                )
                completion(.success(weather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
