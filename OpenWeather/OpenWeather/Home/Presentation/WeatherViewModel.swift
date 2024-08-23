//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by karthikdamera on 23/08/24.
//

import Foundation
import CoreLocation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var temperature: String = ""
    @Published var condition: String = ""
    @Published var cityName: String = ""
    @Published var weatherIconURL: URL?
    @Published var userCityInput: String = ""
    @Published var userStateInput: String = ""
    @Published var userCountryInput: String = ""
    
    private let getWeatherUseCase: GetWeatherUseCase
    private let locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()

    init(getWeatherUseCase: GetWeatherUseCase) {
        self.getWeatherUseCase = getWeatherUseCase
        
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.fetchWeatherForLocation(location)
            }
            .store(in: &cancellables)
    }
    
    func fetchWeatherForCity() {
        var query = userCityInput
        if !userStateInput.isEmpty {
            query += ",\(userStateInput)"
        }
        if !userCountryInput.isEmpty {
            query += ",\(userCountryInput)"
        }

        getWeatherUseCase.execute(for: query) { [weak self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self?.updateWeatherData(with: weather)
                }
            case .failure(let error):
                print("Error fetching weather: \(error)")
            }
        }
    }
    
    func fetchWeatherForLocation(_ location: CLLocation) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        getWeatherUseCase.execute(for: lat, longitude: lon) { [weak self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self?.updateWeatherData(with: weather)
                }
            case .failure(let error):
                print("Error fetching weather: \(error)")
            }
        }
    }
    
    private func updateWeatherData(with weather: Weather) {
        self.temperature = "\(weather.temperature)°C"
        self.condition = weather.condition
        self.cityName = weather.cityName
        self.weatherIconURL = URL(string: "https://openweathermap.org/img/wn/\(weather.iconCode)@2x.png")
    }
}
