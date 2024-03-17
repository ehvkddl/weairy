//
//  Hourly.swift
//  weairy
//
//  Created by do hee kim on 2024/03/17.
//

import Foundation

struct Hourly: Identifiable {
    let id = UUID()
    let dt: String
    let weatherID: Int
    let temp: Int
}

extension Hourly {
    static let dummyHourly = [
        Hourly(dt: DateFormatter.fullHour.string(from: Date(timeIntervalSince1970: 0)), weatherID: 800, temp: 0),
        Hourly(dt: DateFormatter.fullHour.string(from: Date(timeIntervalSince1970: 0)), weatherID: 800, temp: 0),
        Hourly(dt: DateFormatter.fullHour.string(from: Date(timeIntervalSince1970: 0)), weatherID: 800, temp: 0),
        Hourly(dt: DateFormatter.fullHour.string(from: Date(timeIntervalSince1970: 0)), weatherID: 800, temp: 0),
        Hourly(dt: DateFormatter.fullHour.string(from: Date(timeIntervalSince1970: 0)), weatherID: 800, temp: 0),
        Hourly(dt: DateFormatter.fullHour.string(from: Date(timeIntervalSince1970: 0)), weatherID: 800, temp: 0),
        Hourly(dt: DateFormatter.fullHour.string(from: Date(timeIntervalSince1970: 0)), weatherID: 800, temp: 0)
    ]
}
