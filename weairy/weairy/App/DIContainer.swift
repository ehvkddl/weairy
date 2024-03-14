//
//  DIContainer.swift
//  weairy
//
//  Created by do hee kim on 2024/03/13.
//

import Foundation

import Moya

class DIContainer: ObservableObject {
    
    let networkManager: NetworkManager = {
        let providers = NetworkManagerImpl.Providers(
            weatherProvider: MoyaProvider<WeatherAPI>()
        )
        
        return NetworkManagerImpl(providers: providers)
    }()
    
    lazy var services: Service = {
        ServiceImpl(
            weatherService: getWeatherService()
        )
    }()
    
    func getWeatherService() -> WeatherService {
        WeatherServiceImpl(
            provider: getWeatherProvider()
        )
    }
    
    func getWeatherProvider() -> WeatherProvider {
        WeatherProviderImpl(
            networkManager: networkManager
        )
    }
    
}
