//
//  SmallWidgetView.swift
//  weairy
//
//  Created by do hee kim on 2024/03/17.
//

import WidgetKit
import SwiftUI

struct SmallWidgetView: View {
    var entry: Provider.Entry
    
    let current: Current
    
    var body: some View {
        ZStack {
            Color.fancyBlue
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text("서울")
                        .font(WFont.style(.lato, weight: .bold, size: 15))
                    Image(systemName: "location.fill")
                        .resizable()
                        .frame(width: 13, height: 13)
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("\(current.temp)")
                        .font(WFont.style(.poppin, weight: .semiBold, size: 35))
                    Text("°C")
                        .font(WFont.style(.poppin, weight: .regular, size: 12))
                        .padding(.top, 6)
                }

                HStack {
                    Spacer()
                    
                    Image(WeatherCondition.from(statusCode: current.weatherID).rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(CGSize(width: 1.6, height: 1.6))
                        .offset(CGSize(width: -10.0, height: -5.0))
                }
            }
            .padding(15)
            .foregroundStyle(.white)
        }
    }
}

#Preview(as: .systemSmall) {
    WeairyWidget()
} timeline: {
    SimpleEntry(date: .now, weather: .dummyWeather, configuration: ConfigurationAppIntent())
    SimpleEntry(date: .now, weather: .dummyWeather, configuration: ConfigurationAppIntent())
}
