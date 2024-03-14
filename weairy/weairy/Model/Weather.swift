//
//  Weather.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import Foundation

struct Weather {
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current {
    let temp: Int
    let weatherID: Int
    let weatherDescription: String
    let feelsLike: Int
    let clouds: Int
    let uvi: Double
    let visibility: Int
    let windSpeed: Double
    let windGust: Double?
    let windDeg: Int
    let sunrise: Int?
    let sunset: Int?
}

struct Hourly {
    let dt: Int
    let weatherID: Int
    let temp: Int
}

struct Daily {
    let dt: Int
    let weatherID: Int
    let tempMin: Int
    let tempMax: Int
}
