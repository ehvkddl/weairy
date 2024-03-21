//
//  CurrentView.swift
//  WeairyWidgetExtension
//
//  Created by do hee kim on 2024/03/20.
//

import SwiftUI

struct CurrentView: View {
    let current: Current
    
    var body: some View {
        HStack(spacing: 10) {
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
                        .font(WFont.style(.poppin, weight: .semiBold, size: 30))
                    Text("°C")
                        .font(WFont.style(.poppin, weight: .regular, size: 12))
                        .padding(.top, 5)
                }
            }
            .padding(.leading, 2)
            .foregroundStyle(.white)
            
            Image(WeatherCondition.from(statusCode: current.weatherID).rawValue)
                .resizable()
                .scaledToFit()
                .scaleEffect(CGSize(width: 1.2, height: 1.2))
                .frame(height: 50)
            
            Spacer()
        }
    }
}
