//
//  OpenWeatherApp.swift
//  OpenWeather
//
//  Created by karthikdamera on 23/08/24.
//

import SwiftUI

@main
struct OpenWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: AppDIContainer.createWeatherViewModel())
        }
    }
}
