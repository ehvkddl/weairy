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

extension Weather {
    static let dummyWeather = Weather(
        current: Current.dummyCurrent,
        hourly: Hourly.dummyHourly,
        daily: Daily.dummyDaily
    )
}
