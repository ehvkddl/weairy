//
//  Service.swift
//  weairy
//
//  Created by do hee kim on 2024/03/13.
//

import Foundation

protocol Service {
    var weatherService: WeatherService { get set }
    var locationService: LocationService { get set }
}

class ServiceImpl: Service {
    var weatherService: WeatherService
    var locationService: LocationService
    
    init(
        weatherService: WeatherService,
        locationService: LocationService
    ) {
        self.weatherService = weatherService
        self.locationService = locationService
    }
}

class StubServices: Service {
    var weatherService: WeatherService = WeatherServiceImpl(provider: StubWeatherProvider())
    var locationService: LocationService = LocationServiceImpl()
}
