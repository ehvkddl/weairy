//
//  DailyWeatherView.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import SwiftUI

struct DailyWeatherView: View {
    var body: some View {
        HStack {
            Text("금")
                .font(.latoBold18)
                .foregroundStyle(.fancyBlue)
            
            Spacer()
            
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
            .foregroundStyle(.fancyBlue)
        }
        .padding(.horizontal, 23)
        .frame(width: Util.screenWidth, height: 50)
    }
}

#Preview {
    DailyWeatherView()
}
