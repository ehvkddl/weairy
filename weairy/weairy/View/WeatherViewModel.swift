//
//  WeatherViewModel.swift
//  weairy
//
//  Created by do hee kim on 2024/03/14.
//

import Combine
import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherData: AllWeatherResponseDTO?
    
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
                    weatherData = nil
                }
            } receiveValue: { [weak self] response in
                guard let `self` else { return }
                
                weatherData = response
            }
            .store(in: &subscriptions)

    }
    
}
