//
//  LargeWidgetView.swift
//  WeairyWidgetExtension
//
//  Created by do hee kim on 2024/03/17.
//

import WidgetKit
import SwiftUI

struct LargeWidgetView: View {
    var entry: Provider.Entry
    
    let weather: Weather
    
    var body: some View {
        ZStack {
            Color.fancyBlue
            
            VStack(spacing: 12) {
                CurrentView(current: weather.current)
                
                Divider()
                    .overlay(Color.white)
                
                HourlyView(hourly: weather.hourly)
                
                Divider()
                    .overlay(Color.white)
                
                DailyView(daily: weather.daily)
            }
            .padding(.horizontal, 13)
            .padding(.vertical, 17)
            
        }
    }
}

#Preview(as: .systemLarge) {
    WeairyWidget()
} timeline: {
    SimpleEntry(date: .now, weather: .dummyWeather, configuration: ConfigurationAppIntent())
    SimpleEntry(date: .now, weather: .dummyWeather, configuration: ConfigurationAppIntent())
}
