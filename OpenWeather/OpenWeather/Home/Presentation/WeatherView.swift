//
//  WeatherView.swift
//  OpenWeather
//
//  Created by karthikdamera on 23/08/24.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        ScrollView {
            VStack {
                TextField("Enter city name", text: $viewModel.userCityInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Enter state code (optional)", text: $viewModel.userStateInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Enter country code (optional)", text: $viewModel.userCountryInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    viewModel.fetchWeatherForCity()
                }) {
                    Text("Get Weather")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Spacer()
                
                if !viewModel.cityName.isEmpty {
                    Text(viewModel.cityName)
                        .font(.largeTitle)
                        .padding()
                }
                
                if let iconURL = viewModel.weatherIconURL {
                    CachedAsyncImage(url: iconURL)
                        .frame(width: 100, height: 100)
                        .padding()
                }
                
                if !viewModel.temperature.isEmpty {
                    Text(viewModel.temperature)
                        .font(.system(size: 70))
                        .padding()
                }
                
                if !viewModel.condition.isEmpty {
                    Text(viewModel.condition)
                        .font(.title)
                }
            }
            .padding()
        }
    }
}
