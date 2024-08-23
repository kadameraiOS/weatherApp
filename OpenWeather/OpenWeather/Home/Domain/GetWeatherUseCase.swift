//
//  GetWeatherUseCase.swift
//  OpenWeather
//
//  Created by karthikdamera on 23/08/24.
//

import Foundation

protocol WeatherRepository {
    func getWeather(for city: String, completion: @escaping (Result<Weather, Error>) -> Void)
    func getWeather(for latitude: Double, longitude: Double, completion: @escaping (Result<Weather, Error>) -> Void)
}


protocol GetWeatherUseCase {
    func execute(for city: String, completion: @escaping (Result<Weather, Error>) -> Void)
    func execute(for latitude: Double, longitude: Double, completion: @escaping (Result<Weather, Error>) -> Void)
}

class GetWeatherUseCaseImpl: GetWeatherUseCase {
    private let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func execute(for city: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        repository.getWeather(for: city, completion: completion)
    }
    
    func execute(for latitude: Double, longitude: Double, completion: @escaping (Result<Weather, Error>) -> Void) {
        repository.getWeather(for: latitude, longitude: longitude, completion: completion)
    }
}
