//
//  WeatherViewModel.swift
//  weairy
//
//  Created by do hee kim on 2024/03/14.
//

import Combine
import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherData: Weather? = Weather.dummyWeather
    @Published var currentWeather: Current = .dummyCurrent
    @Published var hourlyWeatherDatas: [Hourly] = Hourly.dummyHourly
    @Published var dailyWeatherDatas: [Daily] = Daily.dummyDaily
    
    private var services: Service
    private var subscriptions = Set<AnyCancellable>()
    
    init(services: Service) {
        self.services = services
    }
    
    func fetchWeather() {
        services.weatherService.fetchWeather()
            .sink { [weak self] completion in
                guard let `self` else { return }
                
                if case .failure = completion {
                }
            } receiveValue: { [weak self] response in
                guard let `self` else { return }

                currentWeather = response.current
                
                hourlyWeatherDatas = response.hourly
                hourlyWeatherDatas.removeFirst()
                
                dailyWeatherDatas = response.daily
            }
            .store(in: &subscriptions)

    }
    
}
