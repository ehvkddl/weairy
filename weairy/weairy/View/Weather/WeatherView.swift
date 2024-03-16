//
//  ContentView.swift
//  weairy
//
//  Created by do hee kim on 2024/03/13.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var vm: WeatherViewModel
    
    @State private var showForcastView: Bool = false
    
    @State private var remainingScreenHeight: CGFloat = 0 // CurrentView 제외한 나머지 screen 높이
    @State private var topSafeAreaHeight: CGFloat = 0 // 상단 safeArea 높이
    
    @State private var forecastViewOffsetHeight: CGFloat = Util.screenHeight // ForecastView offset height
    private var plainOffsetHeight: CGFloat { // forcastView 기본 위치
        return Util.screenHeight - remainingScreenHeight - topSafeAreaHeight + 45 // 45: top padding
    }
    private var expandOffsetHeight: CGFloat { // forcastView 확장시 위치
        return topSafeAreaHeight + 30 // 30: 지역명 text height
    }
    
    var body: some View {
        
        // MARK: - CurrentView
        ZStack {
            // MARK: safeArea height
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        let safeAreaHeight = geometry.safeAreaInsets.top
                        
                        topSafeAreaHeight = safeAreaHeight
                        forecastViewOffsetHeight = plainOffsetHeight
                    }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                // MARK: location
                Button{
                    forecastViewOffsetHeight = plainOffsetHeight
                    showForcastView = false
                } label: {
                    HStack(spacing: 0) {
                        Text("서울")
                            .font(.latoBold18)
                        Image(systemName: "location.fill")
                        Text("의 날씨")
                            .font(.latoLight18)
                    }
                    .foregroundStyle(.white)
                }
                .padding(.top, 100)
                .padding(.leading, 20)
                
                
                HStack(spacing: 0) {
                    // MARK: temperature
                    HStack(alignment: .top, spacing: 3) {
                        Text("\(vm.weatherData?.current.temp ?? 0)")
                            .font(.poppinSemiBold110)
                        Text("°C")
                            .padding(.top, 24)
                            .font(.poppinRegular30)
                    }
                    .frame(width: (Util.screenWidth - 40) / 2)
                    .padding(.top, 10)
                    
                    // MARK: weather image
                    Image(.sunCloudHailstone)
                        .resizable()
                        .scaledToFit()
                }
                .padding(.leading, 23)
                .frame(height: 200)
                .foregroundStyle(.white)
                
                // MARK: current weather detail
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0...10, id: \.self) { index in
                            CurrentWeatherView()
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 0)
                .frame(height: (Util.screenWidth / 2 - 30) * 0.82)
                .scrollIndicators(.hidden)
                
                // MARK: remain screen
                GeometryReader { geometry in
                    Rectangle()
                        .foregroundStyle(.clear)
                        .onAppear {
                            let height = geometry.size.height
                            let safeAreaHeight = geometry.safeAreaInsets.top
                            
                            remainingScreenHeight = height
                            
                            forecastViewOffsetHeight = Util.screenHeight - height
                        }
                }
                
                
            }
            .backgroundColor(.fancyBlue)
            
            
            // MARK: - ForecastView
            ZStack {
                // MARK: background
                Rectangle()
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadii: .init(topLeading: 20, topTrailing: 20)))
                
                VStack {
                    // MARK: handle
                    ZStack {
                        Rectangle()
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadii: .init(topLeading: 20, topTrailing: 20)))
                            .frame(width: Util.screenWidth, height: 30)
                        
                        Capsule()
                            .frame(width: 60, height: 5)
                            .foregroundStyle(.quaternary)
                            .padding(.top, 5)
                        
                    }
                    
                    // MARK: forecast content
                    ForecastView(showForecastView: $showForcastView)
                        .scrollDisabled(!showForcastView)
                        .padding(.bottom, 35)
                }
            }
            .ignoresSafeArea()
            .offset(y: forecastViewOffsetHeight)
            .animation(.spring(), value: forecastViewOffsetHeight)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        let gestureY = gesture.translation.height
                        
                        forecastViewOffsetHeight = (showForcastView ? expandOffsetHeight : plainOffsetHeight) + gestureY
                        
                        // 최소, 최대 offset 지정
                        if forecastViewOffsetHeight < expandOffsetHeight {
                            // forcastView가 expandOffset보다 위에 위치하지 않도록 제한
                            forecastViewOffsetHeight = expandOffsetHeight
                        } else if forecastViewOffsetHeight > plainOffsetHeight {
                            // forcastView가 plainOffsetHeight보다 아래에 위치하지 않도록 제한
                            forecastViewOffsetHeight = plainOffsetHeight
                        }
                        
                    }
                    .onEnded { value in
                        let gestureY = value.location.y - value.startLocation.y
                        
                        let isDraggingUp = gestureY < 0
                        let isDraggingDown = gestureY > 0
                        let threshold: CGFloat = 150
                        
                        if isDraggingUp && gestureY < -threshold {
                            showForcastView = true
                        } else if isDraggingDown && gestureY > threshold {
                            showForcastView = false
                        }
                        
                        forecastViewOffsetHeight = showForcastView ? expandOffsetHeight : plainOffsetHeight
                    }
            )
        }
    }
}

#Preview {
    WeatherView(vm: .init(services: StubServices()))
}
