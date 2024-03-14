//
//  DailyDTO.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import Foundation

struct DailyResponseDTO: Codable {
    let dt: Int                           // 예측 데이터 시간
    let sunrise, sunset: Int?             // 일출, 일몰
    let moonrise, moonset: Int            // 월출, 월몰
    let moonPhase: Double                 // 달 위상
    let summary: String                   // 그날의 기상 조건에 대한 사람이 읽을 수 있는 설명
    let temp: TempResponseDTO             // 기온
    let feelsLike: FeelsLikeResponseDTO   // 체감 기온
    let pressure: Int                     // 해수면의 대기압, hPa
    let humidity: Int                     // 습도, %
    let dewPoint: Double                  // 이슬점
    let windSpeed: Double                 // 바람 속도. 단위 – 기본값: 미터/초
    let windGust: Double?                 // 돌풍. 단위 – 기본값: 미터/초
    let windDeg: Int                      // 풍향, 각도(기상)
    let weather: [WeatherResponseDTO]
    let clouds: Int                       // 흐림, %
    let uvi: Double                       // 자외선 지수
    let pop: Double                       // 강수 확률. 매개변수 값은 0과 1 사이에서 다양합니다. 0은 0%, 1은 100%
    let rain: Double?                     // 강수량, mm. 이 매개변수에는 측정 단위로 mm만 사용
    let snow: Double?                     // 적설량, mm. 이 매개변수에는 측정 단위로 mm만 사용

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
struct FeelsLikeResponseDTO: Codable {
    let morn: Double    // 아침 체감 기온
    let day: Double     // 낮 체감 온도
    let eve: Double     // 저녁 체감 기온
    let night: Double   // 밤 체감 온도
}

// MARK: - Temp
struct TempResponseDTO: Codable {
    let morn: Double    // 아침 기온
    let day: Double     // 낮 온도
    let eve: Double     // 저녁 기온
    let night: Double   // 밤 온도
    let min: Double     // 최소 일일 온도
    let max: Double     // 최대 일일 온도
}
