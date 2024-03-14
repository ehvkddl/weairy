//
//  weairyApp.swift
//  weairy
//
//  Created by do hee kim on 2024/03/13.
//

import SwiftUI

@main
struct weairyApp: App {
    @StateObject var container: DIContainer = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .environmentObject(container)
        }
    }
}
