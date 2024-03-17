//
//  Daily.swift
//  weairy
//
//  Created by do hee kim on 2024/03/17.
//

import Foundation

struct Daily: Identifiable {
    let id = UUID()
    let dt: String
    let weatherID: Int
    let tempMin: Int
    let tempMax: Int
}

extension Daily {
    static let dummyDaily = [
        Daily(dt: DateFormatter.day.string(from: Date(timeIntervalSince1970: 1710385200)), weatherID: 800, tempMin: 0, tempMax: 0),
        Daily(dt: DateFormatter.day.string(from: Date(timeIntervalSince1970: 1710385200)), weatherID: 800, tempMin: 0, tempMax: 0),
        Daily(dt: DateFormatter.day.string(from: Date(timeIntervalSince1970: 1710471600)), weatherID: 800, tempMin: 0, tempMax: 0),
        Daily(dt: DateFormatter.day.string(from: Date(timeIntervalSince1970: 1710558000)), weatherID: 800, tempMin: 0, tempMax: 0),
        Daily(dt: DateFormatter.day.string(from: Date(timeIntervalSince1970: 1710644400)), weatherID: 800, tempMin: 0, tempMax: 0),
        Daily(dt: DateFormatter.day.string(from: Date(timeIntervalSince1970: 1710730800)), weatherID: 800, tempMin: 0, tempMax: 0),
        Daily(dt: DateFormatter.day.string(from: Date(timeIntervalSince1970: 1710817200)), weatherID: 800, tempMin: 0, tempMax: 0)
    ]
}
