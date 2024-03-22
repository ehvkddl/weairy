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
            weatherService: getWeatherService(),
            locationService: getLocationService()
        )
    }()
    
    func getWeatherService() -> WeatherService {
        WeatherServiceImpl(
            provider: getWeatherProvider()
        )
    }
    
    func getLocationService() -> LocationService {
        LocationServiceImpl()
    }
    
    func getWeatherProvider() -> WeatherProvider {
        WeatherProviderImpl(
            networkManager: networkManager
        )
    }
    
    func makeWeatherView() -> WeatherView {
        let vm = makeWeatherViewModel()
        return WeatherView(vm: vm)
    }
    
    func makeWeatherViewModel() -> WeatherViewModel {
        WeatherViewModel(services: services)
    }
    
}
