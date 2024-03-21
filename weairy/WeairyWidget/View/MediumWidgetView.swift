//
//  MediumWidgetView.swift
//  weairy
//
//  Created by do hee kim on 2024/03/17.
//

import WidgetKit
import SwiftUI

struct MediumWidgetView: View {
    var entry: Provider.Entry
    
    let weather: Weather
    
    var body: some View {
        ZStack {
            Color.fancyBlue
            
            VStack(spacing: 0) {
                CurrentView(current: weather.current)
                
                Spacer()
                
                HourlyView(hourly: weather.hourly)
            }
            .padding(.all, 13)
        }
    }
}

#Preview(as: .systemMedium) {
    WeairyWidget()
} timeline: {
    SimpleEntry(date: .now, weather: .dummyWeather, configuration: ConfigurationAppIntent())
    SimpleEntry(date: .now, weather: .dummyWeather, configuration: ConfigurationAppIntent())
}
