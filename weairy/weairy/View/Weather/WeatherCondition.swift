//
//  WeatherResource.swift
//  weairy
//
//  Created by do hee kim on 2024/03/16.
//

import Foundation

enum WeatherCondition: String {
    case thunderstorm
    case drizzle
    case rain
    case snow
    case atmosphere
    case clear
    case cloud

    static func from(statusCode: Int) -> WeatherCondition {
        switch statusCode {
        case 200..<300: return .thunderstorm
        case 300..<400: return .drizzle
        case 500..<600: return .rain
        case 600..<700: return .snow
        case 700..<800: return .atmosphere
        case 800: return .clear
        case 801..<900: return .cloud
        default: return .clear
        }
    }
}
