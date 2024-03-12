//
//  DIContainer.swift
//  weairy
//
//  Created by do hee kim on 2024/03/13.
//

import Foundation

class DIContainer: ObservableObject {
    var services: Service
    
    init(services: Service) {
        self.services = services
    }
}
