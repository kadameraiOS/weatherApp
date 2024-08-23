//
//  AppDIContainer.swift
//  OpenWeather
//
//  Created by karthikdamera on 23/08/24.
//

import Foundation
import SwiftUI

class AppDIContainer {
    
    static func createWeatherViewModel() -> WeatherViewModel {
        let apiClient = WeatherAPIClientImpl()
        let weatherRepository = WeatherRepositoryImpl(apiClient: apiClient)
        let getWeatherUseCase = GetWeatherUseCaseImpl(repository: weatherRepository)
        return WeatherViewModel(getWeatherUseCase: getWeatherUseCase)
    }
}
