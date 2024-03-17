//
//  CurrentWeatherDetailCategory.swift
//  weairy
//
//  Created by do hee kim on 2024/03/17.
//

import Foundation

enum CurrentWeatherDetailCategory: String {
    case feelsLike
    case humidity
    case dewPoint
    case clouds
    case uvi
    case visibility
    case windSpeed
    case windGust
    case windDeg
    case sunrise
    case sunset
    
    var title: String {
        switch self {
        case .feelsLike: "체감온도"
        case .humidity: "습도"
        case .dewPoint: "이슬점"
        case .clouds: "흐림"
        case .uvi: "자외선 지수"
        case .visibility: "가시거리"
        case .windSpeed: "바람 속도"
        case .windGust: "돌풍"
        case .windDeg: "풍향"
        case .sunrise: "일출"
        case .sunset: "일몰"
        }
    }
    
    var unit: String? {
        switch self {
        case .feelsLike: "°C"
        case .humidity: "%"
        case .dewPoint: "°C"
        case .clouds: "%"
        case .visibility: "m"
        case .windSpeed: "m/s"
        case .windGust: "m/s"
        default: nil
        }
    }
    
    var order: Int {
        switch self {
        case .feelsLike: 6
        case .humidity: 1
        case .dewPoint: 5
        case .clouds: 3
        case .uvi: 2
        case .visibility: 4
        case .windSpeed: 7
        case .windGust: 8
        case .windDeg: 9
        case .sunrise: 10
        case .sunset: 11
        }
    }
}
