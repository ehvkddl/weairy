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
    
}
