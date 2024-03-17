//
//  ForcastView.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import SwiftUI

struct ForecastView: View {
    @Binding var hourlyWeather: [Hourly]
    @Binding var dailyWeather: [Daily]
    
    @Binding var showForecastView: Bool
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                Rectangle()
                    .id(0)
                    .frame(height: 0)
                
                HStack {
                    Text("시간별 날씨")
                        .font(WFont.style(.lato, weight: .bold, size: 18))
                        .foregroundStyle(.fancyBlue)
                    
                    Spacer()
                }
                .padding(.leading, 17)
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 14) {
                        ForEach(hourlyWeather) {
                            HourlyWeatherView(weather: $0)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: Util.screenWidth * 0.25 * 1.3)
                .padding(.top, 7)
                .padding(.bottom, 25)
                .scrollIndicators(.hidden)
                
                HStack {
                    Text("요일별 날씨")
                        .font(WFont.style(.lato, weight: .bold, size: 18))
                        .foregroundStyle(.fancyBlue)
                    
                    Spacer()
                }
                .padding(.leading, 17)
                
                VStack {
                    ForEach(Array(zip(dailyWeather.indices, dailyWeather)), id: \.0) { idx, item in
                        DailyWeatherView(weather: item)
                        
                        if idx < 8 {
                            Divider()
                                .padding(.horizontal, 23)
                        }
                    }
                    
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(height: 50)
                }
                
            }
            .scrollIndicators(.hidden)
            .onChange(of: showForecastView) { newValue in
                // showForcastView가 false가 되면 맨 위로 스크롤
                if !newValue {
                    withAnimation {
                        proxy.scrollTo(0, anchor: .top)
                    }
                }
            }
        }
        
    }
}

#Preview {
    ForecastView(hourlyWeather: .constant(Hourly.dummyHourly), 
                 dailyWeather: .constant(Daily.dummyDaily),
                 showForecastView: .constant(false))
}
