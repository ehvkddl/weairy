//
//  weatherAPI.swift
//  weairy
//
//  Created by do hee kim on 2024/03/13.
//

import Foundation

import Moya

enum WeatherAPI {
    case fetchAll(query: [String: Any])
    case fetchCityName(query: [String: Any])
}

extension WeatherAPI: TargetType {
    
    var baseURL: URL {
        URL(string: Configurations.baseURL)!
    }
    
    var path: String {
        switch self {
        case .fetchAll: "data/3.0/onecall"
        case .fetchCityName: "geo/1.0/reverse"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAll, .fetchCityName: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchAll(let query):
            return .requestParameters(parameters: query, encoding: URLEncoding.queryString)
        case .fetchCityName(let query):
            return .requestParameters(parameters: query, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
}
