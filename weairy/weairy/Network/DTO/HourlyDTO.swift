//
//  HourlyDTO.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import Foundation

struct HourlyResponseDTO: Decodable {
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
    let weather: [WeatherResponseDTO]
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
