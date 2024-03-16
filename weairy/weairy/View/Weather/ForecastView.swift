//
//  ForcastView.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import SwiftUI

struct ForecastView: View {
    @Binding var showForecastView: Bool
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                Rectangle()
                    .id(0)
                    .frame(height: 0)
                
                HStack {
                    Text("시간별 날씨")
                        .font(.latoBold18)
                        .foregroundStyle(.fancyBlue)
                    
                    Spacer()
                }
                .padding(.leading, 17)
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 14) {
                        ForEach(0...10, id: \.self) { index in
                            HourlyWeatherView()
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
                        .font(.latoBold18)
                        .foregroundStyle(.fancyBlue)
                    
                    Spacer()
                }
                .padding(.leading, 17)
                
                VStack {
                    ForEach(1...8, id: \.self) { i in
                        DailyWeatherView()
                        
                        if i < 8 {
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
    ForecastView(showForecastView: .constant(false))
}
