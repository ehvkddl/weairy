//
//  WeatherService.swift
//  weairy
//
//  Created by do hee kim on 2024/03/13.
//

import Combine
import Foundation

protocol WeatherService {
    func fetchWeather(
        latitude: Double,
        longitude: Double
    ) -> AnyPublisher<Weather, NetworkError>
    
    func fetchCityName(lat: Double, lon: Double) -> AnyPublisher<String, Error>
}

class WeatherServiceImpl: WeatherService {
    
    private var subscriptions = Set<AnyCancellable>()
    
    var provider: WeatherProvider
    
    init(provider: WeatherProvider) {
        self.provider = provider
    }
    
}

extension WeatherServiceImpl {
    
    func fetchWeather(
        latitude: Double,
        longitude: Double
    ) -> AnyPublisher<Weather, NetworkError> {
        let query = [
            "lat": "\(latitude)",
            "lon": "\(longitude)",
            "appid": Configurations.weatherKey,
            "units": "metric",
            "lang": "kr",
            "exclude": "minutely,alerts"
        ]
        
        return Future<Weather, NetworkError> { [weak self] promise in
            guard let `self` else { return }
            
            provider.fetchWeather(query: query)
                .sink { completion in
                    if case .failure(let error) = completion {
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    let weather = response.toModel()
                    
                    promise(.success(weather))
                }
                .store(in: &subscriptions)
        }
        .eraseToAnyPublisher()
        
    }
    
    func fetchCityName(lat: Double, lon: Double) -> AnyPublisher<String, Error> {
        let query = [
            "lat": "\(lat)",
            "lon": "\(lon)",
            "appid": Configurations.weatherKey,
        ]
        
        return Future<String, Error> { [weak self] promise in
            guard let `self` else { return }
            
            provider.fetchCityName(query: query)
                .sink { completion in
                    if case .failure(let error) = completion {
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    guard let response = response.first else {
                        promise(.failure(NetworkError.dataNotFound))
                        return
                    }
                    
                    let cityName = response.localNames.ko
                    
                    promise(.success(cityName))
                }
                .store(in: &subscriptions)
        }
        .eraseToAnyPublisher()
    }
    
}
