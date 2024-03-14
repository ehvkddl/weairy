//
//  ContentView.swift
//  weairy
//
//  Created by do hee kim on 2024/03/13.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var vm: WeatherViewModel
    
    var body: some View {
        VStack {
            Text("\(vm.weatherData?.current.weather[0].description ?? "날씨 없음")")
        }
        .padding()
        .onAppear {
            vm.fetchWeather()
        }
    }
}

#Preview {
    WeatherView(vm: .init(services: StubServices()))
}
