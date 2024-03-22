//
//  LocationDTO.swift
//  weairy
//
//  Created by do hee kim on 2024/03/22.
//

import Foundation

struct LocationResponseDTO: Decodable {
    let name: String
    let localNames: LocalNames
    let lat: Double
    let lon: Double
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat
        case lon
        case country
    }
}

struct LocalNames: Decodable {
    let ko: String
}
