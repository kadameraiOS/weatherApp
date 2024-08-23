//
//  WeatherResponse.swift
//  OpenWeather
//
//  Created by karthikdamera on 23/08/24.
//

import Foundation

struct WeatherResponse: Codable {
    let main: Main
    let weather: [WeatherCondition]
    let name: String
    
    struct Main: Codable {
        let temp: Double
    }
    
    struct WeatherCondition: Codable {
        let description: String
        let icon: String
    }
}

