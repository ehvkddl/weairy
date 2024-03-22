//
//  SuggestionItemView.swift
//  weairy
//
//  Created by do hee kim on 2024/03/23.
//

import SwiftUI

struct SuggestionItemView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 13) {
                Image(.mapPin)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(.dailyBlue)
                    .scaledToFill()
                    .frame(width: 27, height: 25)
                
                Text(title)
                    .foregroundStyle(.primary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.secondary)
    }
}

#Preview {
    SuggestionItemView(title: "서울특별시", action: {})
}
