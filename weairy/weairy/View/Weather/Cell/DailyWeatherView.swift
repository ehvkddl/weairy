//
//  DailyWeatherView.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import SwiftUI

struct DailyWeatherView: View {
    let weather: Daily
    
    var body: some View {
        HStack {
            Text(weather.dt)
                .font(WFont.style(.lato, weight: .bold, size: 18))
                .foregroundStyle(.fancyBlue)
            
            Spacer()
            
            Image(WeatherCondition.from(statusCode: weather.weatherID).rawValue)
                .resizable()
                .scaledToFit()
                .padding(.trailing, 5)
            
            HStack(spacing: 10) {
                HStack(alignment: .top, spacing: 0) {
                    Spacer()
                    Text("\(weather.tempMin)")
                        .font(WFont.style(.poppin, weight: .medium, size: 22))
                    Text("°C")
                        .font(WFont.style(.poppin, weight: .medium, size: 22))
                        .padding(.top, 3)
                }
                .frame(width: 45)
                .foregroundStyle(.fancyBlue)
                
                HStack(alignment: .top, spacing: 0) {
                    Text("\(weather.tempMax)")
                        .font(WFont.style(.poppin, weight: .medium, size: 22))
                    Text("°C")
                        .font(WFont.style(.poppin, weight: .medium, size: 22))
                        .padding(.top, 3)
                }
                .frame(width: 45)
                .foregroundStyle(.transitionBlue)
            }
            
        }
        .padding(.horizontal, 23)
        .frame(width: Util.screenWidth, height: 50)
    }
}

#Preview {
    DailyWeatherView(weather: Daily.dummyDaily[0])
}
