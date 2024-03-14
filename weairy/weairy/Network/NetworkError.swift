//
//  NetworkError.swift
//  weairy
//
//  Created by do hee kim on 2024/03/14.
//

import Foundation

enum NetworkError: Int, Error {
    case requestFail
    case decodingFail
    
    case invalidRequest = 400
    case invalidAuthentication = 401
    case dataNotFound = 404
    case requestOverLimit = 429
    
    case unexpectedServerError
}
