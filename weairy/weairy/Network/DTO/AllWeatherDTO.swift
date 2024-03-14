//
//  WeatherDTO.swift
//  weairy
//
//  Created by do hee kim on 2024/03/14.
//

import Foundation

// MARK: - WeatherResponseDTO
struct AllWeatherResponseDTO: Decodable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: CurrentResponseDTO
    let hourly: [HourlyResponseDTO]
    let daily: [DailyResponseDTO]

    enum CodingKeys: String, CodingKey {
        case lat, lon
        case timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
}
