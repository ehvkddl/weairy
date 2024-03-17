//
//  DateFormmater+.swift
//  weairy
//
//  Created by do hee kim on 2024/03/17.
//

import Foundation

extension DateFormatter {
    
    enum DateFormat: String {
        case day = "EEEEE"
        case fullHour = "HH:mm"
        case timeWithPeriod = "a hh:mm"
    }
    
    static let day: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.day.rawValue
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.locale = Locale(identifier: "ko")
        return formatter
    }()
    
    static let fullHour: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.fullHour.rawValue
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.locale = Locale(identifier: "ko")
        return formatter
    }()
    
    static let timeWithPeriod: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.timeWithPeriod.rawValue
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.locale = Locale(identifier: "ko")
        return formatter
    }()
    
}
