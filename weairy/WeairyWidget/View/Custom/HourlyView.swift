//
//  HourlyView.swift
//  WeairyWidgetExtension
//
//  Created by do hee kim on 2024/03/19.
//

import SwiftUI

struct HourlyView: View {
    let hourly: [Hourly]
    
    var body: some View {
        HStack {
            ForEach(1...6, id: \.self) { i in
                HourlyViewCell(hour: hourly[i])
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    HourlyView(hourly: Hourly.dummyHourly)
}

//.font(WFont.style(.poppin, weight: .regular, size: 12))

struct HourlyViewCell: View {
    let hour: Hourly
    
    var body: some View {
        VStack(spacing: 0) {
            Text(hour.dt)
                .font(WFont.style(.poppin, weight: .regular, size: 13))
            Image(WeatherCondition.from(statusCode: hour.weatherID).rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            HStack(alignment: .top, spacing: 3) {
                Text("\(hour.temp)")
                    .font(WFont.style(.poppin, weight: .semiBold, size: 15))
                Text("°C")
                    .font(WFont.style(.poppin, weight: .regular, size: 10))
                    .padding(.top, 2)
            }
        }
        .foregroundStyle(.white)
    }
}
