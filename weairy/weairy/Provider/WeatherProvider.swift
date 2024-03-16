//
//  WeatherProvider.swift
//  weairy
//
//  Created by do hee kim on 2024/03/13.
//

import Combine
import Foundation

protocol WeatherProvider {
    func fetchWeather(query: [String: Any]) -> AnyPublisher<AllWeatherResponseDTO, NetworkError>
}

class WeatherProviderImpl: WeatherProvider {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension WeatherProviderImpl {
    
    func fetchWeather(query: [String: Any]) -> AnyPublisher<AllWeatherResponseDTO, NetworkError> {
        return networkManager.request(
            target: WeatherAPI.fetchAll(query: query),
            responseType: AllWeatherResponseDTO.self
        )
    }
    
}

class StubWeatherProvider: WeatherProvider {
    
    func fetchWeather(query: [String : Any]) -> AnyPublisher<AllWeatherResponseDTO, NetworkError> {
        Empty().eraseToAnyPublisher()
    }
    
}
