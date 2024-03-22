//
//  WeatherViewModel.swift
//  weairy
//
//  Created by do hee kim on 2024/03/14.
//

import Combine
import Foundation

class WeatherViewModel: ObservableObject {
    @Published var currentWeather: Current = .dummyCurrent
    @Published var hourlyWeatherDatas: [Hourly] = Hourly.dummyHourly
    @Published var dailyWeatherDatas: [Daily] = Daily.dummyDaily
    
    private var services: Service
    private var subscriptions = Set<AnyCancellable>()
    
    init(services: Service) {
        self.services = services
    }
    
    func fetchWeather() {
        let location = services.locationService.fetchCurrentLocationCoordinates()
        
        guard let location else { return }
        
        services.weatherService.fetchWeather(
            latitude: location.latitude,
            longitude: location.longitude
        )
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
