//
//  currentWeatherCell.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import SwiftUI

struct CurrentWeatherView: View {
    let detail: Current.DetailData
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(detail.category.rawValue)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .padding(.leading, 8)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text(detail.category.title)
                    .padding(.top, 8)
                    .padding(.leading, 16)
                
                HStack(alignment: .top, spacing: 0) {
                    Text(detail.processedData)
                        .font(WFont.style(.lato, weight: .bold, size: 30))
                        .minimumScaleFactor(0.3)
                    Text(detail.category.unit ?? "")
                        .padding(.top, 6)
                }
                .padding(.horizontal, 16)
            }
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
    CurrentWeatherView(detail: Current.DetailData(category: .humidity, rawData: 80))
}
