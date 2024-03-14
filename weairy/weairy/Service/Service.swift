//
//  Service.swift
//  weairy
//
//  Created by do hee kim on 2024/03/13.
//

import Foundation

protocol Service {
    var weatherService: WeatherService { get set }
}

class ServiceImpl: Service {
    var weatherService: WeatherService
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
}
