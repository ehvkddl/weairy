//
//  WeatherProvider.swift
//  weairy
//
//  Created by do hee kim on 2024/03/13.
//

import Combine
import Foundation

protocol WeatherProvider {
    func fetchWeather(query: [String: Any]) -> AnyPublisher<WeatherResponseDTO, NetworkError>
}

class WeatherProviderImpl: WeatherProvider {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension WeatherProviderImpl {
    
    func fetchWeather(query: [String: Any]) -> AnyPublisher<WeatherResponseDTO, NetworkError> {
        return networkManager.request(
            target: WeatherAPI.fetchAll(query: query),
            responseType: WeatherResponseDTO.self
        )
    }
    
}

class StubWeatherProvider: WeatherProvider {
    
    func fetchWeather(query: [String : Any]) -> AnyPublisher<WeatherResponseDTO, NetworkError> {
        Empty().eraseToAnyPublisher()
    }
    
}
