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
            locationService: getLocationService(),
            notificationService: getNotificationService()
        )
    }()
    
    // MARK: - Services
    func getWeatherService() -> WeatherService {
        WeatherServiceImpl(
            provider: getWeatherProvider()
        )
    }
    
    func getLocationService() -> LocationService {
        LocationServiceImpl()
    }
    
    func getNotificationService() -> NotificationService {
        NotificationServiceImpl()
    }
    
    // MARK: - Providers
    func getWeatherProvider() -> WeatherProvider {
        WeatherProviderImpl(
            networkManager: networkManager
        )
    }
    
    // MARK: - Views
    func makeWeatherView() -> WeatherView {
        let vm = makeWeatherViewModel()
        return WeatherView(vm: vm)
    }
    
    // MARK: - ViewModels
    func makeWeatherViewModel() -> WeatherViewModel {
        WeatherViewModel(services: services)
    }
    
    func makeCitySerchViewModel() -> CitySearchViewModel {
        CitySearchViewModel(services: services)
    }
    
    func makeNotificationViewModel() -> NotificationViewModel {
        NotificationViewModel(services: services)
    }
    
}
