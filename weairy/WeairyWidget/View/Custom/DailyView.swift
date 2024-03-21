//
//  DailyView.swift
//  WeairyWidgetExtension
//
//  Created by do hee kim on 2024/03/20.
//

import WidgetKit
import SwiftUI

struct DailyView: View {
    let daily: [Daily]
    
    var body: some View {
        VStack {
            ForEach(0...4, id: \.self) { i in
                DailyViewCell(daily: daily[i])
            }
        }
    }
}

#Preview(as: .systemLarge) {
    WeairyWidget()
} timeline: {
    SimpleEntry(date: .now, weather: .dummyWeather, configuration: ConfigurationAppIntent())
}

struct DailyViewCell: View {
    let daily: Daily
    
    var body: some View {
        HStack {
            Text(daily.dt)
                .font(WFont.style(.lato, weight: .bold, size: 15))
            
            Spacer()
            
            Image(WeatherCondition.from(statusCode: daily.weatherID).rawValue)
                .resizable()
                .scaledToFit()
            
            HStack(spacing: 10) {
                HStack(alignment: .top, spacing: 0) {
                    Spacer()
                    Text("\(daily.tempMin)")
                        .font(WFont.style(.poppin, weight: .semiBold, size: 15))
                    Text("°C")
                        .font(WFont.style(.poppin, weight: .regular, size: 10))
                        .padding(.top, 2)
                }
                .frame(width: 45)
                
                HStack(alignment: .top, spacing: 0) {
                    Spacer()
                    Text("\(daily.tempMax)")
                        .font(WFont.style(.poppin, weight: .semiBold, size: 15))
                    Text("°C")
                        .font(WFont.style(.poppin, weight: .regular, size: 10))
                        .padding(.top, 2)
                }
                .frame(width: 45)
            }
            
        }
        .padding(.leading, 5)
        .frame(height: 23)
        .foregroundStyle(.white)
    }
}
