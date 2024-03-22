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
            
            HStack(spacing: 10) {
                HStack(alignment: .top, spacing: 0) {
                    Spacer()
                    Text("\(weather.tempMin)")
                        .font(WFont.style(.poppin, weight: .medium, size: 22))
                        .minimumScaleFactor(0.5)
                    Text("°C")
                        .font(WFont.style(.poppin, weight: .medium, size: 12))
                        .padding(.top, 3)
                }
                .frame(width: 48, alignment: .trailing)
                .foregroundStyle(.fancyBlue)
                
                HStack(alignment: .top, spacing: 0) {
                    Text("\(weather.tempMax)")
                        .font(WFont.style(.poppin, weight: .medium, size: 22))
                        .minimumScaleFactor(0.5)
                    Text("°C")
                        .font(WFont.style(.poppin, weight: .medium, size: 12))
                        .padding(.top, 3)
                }
                .frame(width: 48, alignment: .trailing)
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
