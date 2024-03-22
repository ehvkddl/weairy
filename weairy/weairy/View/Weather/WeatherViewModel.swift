//
//  WeatherViewModel.swift
//  weairy
//
//  Created by do hee kim on 2024/03/14.
//

import Combine
import Foundation

class WeatherViewModel: ObservableObject {
    @Published var currentWeather: Current = .dummyCurrent
    @Published var hourlyWeatherDatas: [Hourly] = Hourly.dummyHourly
    @Published var dailyWeatherDatas: [Daily] = Daily.dummyDaily
    
    @Published var cityName: String = "--"
    
    private var services: Service
    private var subscriptions = Set<AnyCancellable>()
    
    init(services: Service) {
        self.services = services
    }
    
    func fetchWeather(of coordinate: Coordinate?) {
        guard let coordinate else {
            let location = services.locationService.fetchCurrentLocationCoordinates()
            
            guard let l = location else { return }
            let coordinate = Coordinate(latitude: l.latitude, longitude: l.longitude)
            
            setWeatherView(coordinate: coordinate)
            
            return
        }
        
        setWeatherView(coordinate: coordinate)
    }
    
    func setWeatherView(coordinate c: Coordinate) {
        setCityName(lat: c.latitude, lon: c.longitude)
        setWeather(lat: c.latitude, lon: c.longitude)
    }
    
    func setWeather(lat: Double, lon: Double) {
        services.weatherService.fetchWeather(latitude: lat, longitude: lon)
        .sink { [weak self] completion in
            guard let `self` else { return }
            
            if case .failure = completion {
                cityName = "--"
            }
        } receiveValue: { [weak self] response in
            guard let `self` else { return }
            
            currentWeather = response.current
            
            hourlyWeatherDatas = response.hourly
            hourlyWeatherDatas.removeFirst()
            
            dailyWeatherDatas = response.daily
        }
        .store(in: &subscriptions)
    }
    
    func setCityName(lat: Double, lon: Double) {
        services.weatherService.fetchCityName(lat: lat, lon: lon)
            .sink { [weak self] completion in
                guard let `self` else { return }
                
                if case .failure = completion {
                    cityName = "--"
                }
            } receiveValue: { [weak self] response in
                guard let `self` else { return }
                
                cityName = response
            }
            .store(in: &subscriptions)

    }
    
}
