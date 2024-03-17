//
//  Current.swift
//  weairy
//
//  Created by do hee kim on 2024/03/17.
//

import Foundation

struct Current {
    let temp: Int
    let weatherID: Int
    let weatherDescription: String
    let details: [DetailData]
    
    struct DetailData: Identifiable {
        let id = UUID()
        let category: CurrentWeatherDetailCategory
        let rawData: Int
        var processedData: String {
            switch category {
            case .windDeg: return getWindDirection(from: rawData)
            case .sunrise, .sunset:
                let date = Date(timeIntervalSince1970: Double(rawData))
                return DateFormatter.timeWithPeriod.string(from: date)
            default: return "\(rawData)"
            }
        }
        
        func getWindDirection(from degrees: Int) -> String {
            let directions = ["북", "북동", "동", "남동", "남", "남서", "서", "북서"]
            let index = (degrees + 22) / 45 % directions.count
            return directions[index]
        }
    }
}

extension Current {
    static let dummyCurrent = Current(temp: 0,
                                      weatherID: 800,
                                      weatherDescription: "맑음",
                                      details: [
                                        Current.DetailData(category: .humidity, rawData: 0),
                                        Current.DetailData(category: .uvi, rawData: 0),
                                        Current.DetailData(category: .clouds, rawData: 0)
                                      ])
}
