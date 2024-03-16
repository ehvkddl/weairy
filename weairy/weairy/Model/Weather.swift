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

extension Weather {
    static let dummyWeather = Weather(
        current: Current.dummyCurrent,
        hourly: Hourly.dummyHourly,
        daily: Daily.dummyDaily
    )
}

extension Current {
    static let dummyCurrent = Current(temp: 15,
                                      weatherID: 800,
                                      weatherDescription: "맑음",
                                      feelsLike: 14,
                                      clouds: 0,
                                      uvi: 1.26,
                                      visibility: 10000,
                                      windSpeed: 3.9,
                                      windGust: 4.79,
                                      windDeg: 260,
                                      sunrise: 1710366292,
                                      sunset: 1710409072)
}

extension Hourly {
    static let dummyHourly = [
        Hourly(dt: 1710399600, weatherID: 800, temp: 16),
        Hourly(dt: 1710403200, weatherID: 800, temp: 16),
        Hourly(dt: 1710406800, weatherID: 800, temp: 16),
        Hourly(dt: 1710410400, weatherID: 800, temp: 16),
        Hourly(dt: 1710414000, weatherID: 800, temp: 16),
        Hourly(dt: 1710417600, weatherID: 800, temp: 16),
        Hourly(dt: 1710421200, weatherID: 800, temp: 16)
    ]
}

extension Daily {
    static let dummyDaily = [
        Daily(dt: 1710385200, weatherID: 800, tempMin: 4, tempMax: 16),
        Daily(dt: 1710471600, weatherID: 800, tempMin: 4, tempMax: 16),
        Daily(dt: 1710558000, weatherID: 800, tempMin: 4, tempMax: 16),
        Daily(dt: 1710644400, weatherID: 800, tempMin: 4, tempMax: 16),
        Daily(dt: 1710730800, weatherID: 800, tempMin: 4, tempMax: 16),
        Daily(dt: 1710817200, weatherID: 800, tempMin: 4, tempMax: 16),
    ]
}
