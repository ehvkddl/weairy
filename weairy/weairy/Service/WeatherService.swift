//
//  WeatherService.swift
//  weairy
//
//  Created by do hee kim on 2024/03/13.
//

import Combine
import Foundation

protocol WeatherService {
    func fetchWeather() -> AnyPublisher<AllWeatherResponseDTO, NetworkError>
}

class WeatherServiceImpl: WeatherService {
    
    var provider: WeatherProvider
    
    init(provider: WeatherProvider) {
        self.provider = provider
    }
    
}

extension WeatherServiceImpl {
    
    func fetchWeather() -> AnyPublisher<AllWeatherResponseDTO, NetworkError> {
        let query = [
            "lat": "37.5665851",
            "lon": "126.9782038",
            "appid": Configurations.weatherKey,
            "units": "metric",
            "lang": "kr",
            "exclude": "minutely,alerts"
        ]
        
        return provider.fetchWeather(query: query)
    }
    
}
