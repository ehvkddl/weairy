//
//  currentWeatherCell.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import SwiftUI

struct CurrentWeatherView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(.waterDrop)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .padding(.leading, 8)
                Spacer()
            }
            
            Text("습도")
                .padding(.top, 8)
                .padding(.leading, 16)
            
            HStack(spacing: 0) {
                Text("55")
                    .font(.latoBold30)
                Text("%")
            }
            .padding(.leading, 16)
        }
        .frame(width: Util.screenWidth / 2 - 30, height: (Util.screenWidth / 2 - 30) * 0.82)
        .foregroundStyle(.white)
        .background {
            Rectangle()
                .foregroundStyle(.dailyBlue)
                .clipShape(.rect(cornerRadius: 20))
        }
    }
}

#Preview {
    CurrentWeatherView()
}
