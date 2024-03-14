//
//  WeatherDTO.swift
//  weairy
//
//  Created by do hee kim on 2024/03/14.
//

import Foundation

// MARK: - WeatherResponseDTO
struct WeatherResponseDTO: Decodable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon
        case timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - Current
struct Current: Decodable {
    let dt: Int                 // 현재시간. UTC
    let sunrise, sunset: Int?   // 일몰, 일출
    let temp: Double            // 온도
    let feelsLike: Double       // 체감 온도
    let pressure: Int           // 해수면의 대기압
    let humidity: Int           // 습도, %
    let dewPoint: Double        // 이슬점 - 물방울이 응결되기 시작하고 이슬이 맺힐 수 있는 대기 온도(압력과 습도에 따라 다름)
    let uvi: Double             // 자외선 지수
    let clouds: Int             // 흐림, %
    let visibility: Int         // 평균 가시성(미터) 가시성의 최대 값은 10km
    let windSpeed: Double       // 바람 속도. 단위 – 기본값: 미터/초
    let windGust: Double?        // 돌풍. 단위 – 기본값: 미터/초
    let windDeg: Int            // 풍향, 각도(기상)
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
    }
}

// MARK: - Hourly
struct Hourly: Decodable {
    let dt: Int                 // 예측 데이터 시간. UTC
    let sunrise, sunset: Int?   // 일몰, 일출
    let temp: Double            // 온도
    let feelsLike: Double       // 체감 온도
    let pressure: Int           // 해수면의 대기압
    let humidity: Int           // 습도, %
    let dewPoint: Double        // 이슬점 - 물방울이 응결되기 시작하고 이슬이 맺힐 수 있는 대기 온도(압력과 습도에 따라 다름)
    let uvi: Double             // 자외선 지수
    let clouds: Int             // 흐림, %
    let visibility: Int         // 평균 가시성(미터) 가시성의 최대 값은 10km
    let windSpeed: Double       // 바람 속도. 단위 – 기본값: 미터/초
    let windGust: Double        // 돌풍. 단위 – 기본값: 미터/초
    let windDeg: Int            // 풍향, 각도(기상)
    let weather: [Weather]
    let pop: Int                // 강수 확률. 매개변수 값은 0과 1 사이에서 다양합니다. 0은 0%, 1은 100%

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, pop
    }
}

// MARK: - Daily
struct Daily: Codable {
    let dt: Int                     // 예측 데이터 시간
    let sunrise, sunset: Int?       // 일출, 일몰
    let moonrise, moonset: Int      // 월출, 월몰
    let moonPhase: Double           // 달 위상
    let summary: String             // 그날의 기상 조건에 대한 사람이 읽을 수 있는 설명
    let temp: Temp                  // 기온
    let feelsLike: FeelsLike        // 체감 기온
    let pressure: Int               // 해수면의 대기압, hPa
    let humidity: Int               // 습도, %
    let dewPoint: Double            // 이슬점
    let windSpeed: Double           // 바람 속도. 단위 – 기본값: 미터/초
    let windGust: Double?           // 돌풍. 단위 – 기본값: 미터/초
    let windDeg: Int                // 풍향, 각도(기상)
    let weather: [Weather]
    let clouds: Int                 // 흐림, %
    let uvi: Double                 // 자외선 지수
    let pop: Double                 // 강수 확률. 매개변수 값은 0과 1 사이에서 다양합니다. 0은 0%, 1은 100%
    let rain: Double?               // 강수량, mm. 이 매개변수에는 측정 단위로 mm만 사용
    let snow: Double?               // 적설량, mm. 이 매개변수에는 측정 단위로 mm만 사용

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case summary, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi, rain, snow
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let morn: Double    // 아침 체감 기온
    let day: Double     // 낮 체감 온도
    let eve: Double     // 저녁 체감 기온
    let night: Double   // 밤 체감 온도
}

// MARK: - Temp
struct Temp: Codable {
    let morn: Double    // 아침 기온
    let day: Double     // 낮 온도
    let eve: Double     // 저녁 기온
    let night: Double   // 밤 온도
    let min: Double     // 최소 일일 온도
    let max: Double     // 최대 일일 온도
}
