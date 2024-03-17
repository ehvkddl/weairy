//
//  CurrentDTO.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import Foundation

struct CurrentResponseDTO: Decodable {
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
    let windGust: Double?       // 돌풍. 단위 – 기본값: 미터/초
    let windDeg: Int            // 풍향, 각도(기상)
    let weather: [WeatherResponseDTO]

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

extension CurrentResponseDTO {
    func toModel() -> Current {
        var detailDatas: [Current.DetailData] = []
        
        detailDatas.append(Current.DetailData(category: .feelsLike, rawData: Int(round(feelsLike))))
        detailDatas.append(Current.DetailData(category: .humidity, rawData: Int(humidity)))
        detailDatas.append(Current.DetailData(category: .dewPoint, rawData: Int(round(dewPoint))))
        detailDatas.append(Current.DetailData(category: .clouds, rawData: clouds))
        detailDatas.append(Current.DetailData(category: .uvi, rawData: Int(round(uvi))))
        detailDatas.append(Current.DetailData(category: .visibility, rawData: visibility))
        detailDatas.append(Current.DetailData(category: .windSpeed, rawData: Int(round(windSpeed))))
        if let windGust {
            detailDatas.append(Current.DetailData(category: .windGust, rawData: Int(round(windGust))))
        }
        detailDatas.append(Current.DetailData(category: .windDeg, rawData: windDeg))
        if let sunrise, let sunset {
            detailDatas.append(Current.DetailData(category: .sunrise, rawData: sunrise))
            detailDatas.append(Current.DetailData(category: .sunset, rawData: sunset))
        }
        
        detailDatas.sort { $0.category.order < $1.category.order }
        
        return .init(temp: Int(temp),
                     weatherID: weather[0].id,
                     weatherDescription: weather[0].description,
                     details: detailDatas
        )
    }
}
