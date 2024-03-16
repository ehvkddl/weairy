//
//  WeatherForcastCell.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import SwiftUI

struct HourlyWeatherView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.dailyBlue)
                .clipShape(.rect(cornerRadius: 18))
            
            Rectangle()
                .foregroundStyle(.white.opacity(0.8))
                .clipShape(.rect(cornerRadii: .init(bottomLeading: 18, bottomTrailing: 18)))
                .padding(.top, 34)
            
            VStack(spacing: 0) {
                Text("14:00")
                    .font(.latoRegular18)
                    .foregroundStyle(.white)
                    .padding(.top, 7)
                
                Image(.sunCloudHailstone)
                    .resizable()
                    .scaledToFit()
                    
                HStack(alignment: .top, spacing: 0) {
                    Text("22")
                        .font(.poppinMedium22)
                    
                    Text("°C")
                        .font(.poppinMedium12)
                        .padding(.top, 3)
                }
                .foregroundStyle(.darkBlue)
                .padding(.bottom, 5)
            }
        }
        .frame(width: Util.screenWidth * 0.23, height: Util.screenWidth * 0.25 * 1.3)
    }
}

#Preview {
    HourlyWeatherView()
}
