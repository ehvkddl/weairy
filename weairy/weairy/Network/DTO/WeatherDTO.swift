//
//  WeatherDTO.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import Foundation

struct WeatherResponseDTO: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
