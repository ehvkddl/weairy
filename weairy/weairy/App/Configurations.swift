//
//  Configurations.swift
//  weairy
//
//  Created by do hee kim on 2024/03/14.
//

import Foundation

enum Configurations {
    
    static let baseURL: String = {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("baseURL must not be empty in plist")
        }
        print(url)
        return url
    }()
    
    static let weatherKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String else {
            fatalError("weather api key must not be empty in plist")
        }
        return key
    }()
    
}
