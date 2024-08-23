//
//  WeatherAPIClient.swift
//  OpenWeather
//
//  Created by karthikdamera on 23/08/24.
//

import Foundation

protocol WeatherAPIClient {
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
    func fetchWeather(for latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}

class WeatherAPIClientImpl: WeatherAPIClient {
    private let apiKey = "5b06f2c8de52cd9feb2cae960e2376d1"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let urlString = "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchWeather(for latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let urlString = "\(baseURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
