//
//  errorView.swift
//  WeairyWidgetExtension
//
//  Created by do hee kim on 2024/03/20.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "xmark.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(.red)
            
            Text("날씨를 불러오지 못했습니다.")
                .foregroundStyle(.gray)
                .font(.footnote)
                .multilineTextAlignment(.center)
        }
        .padding(15)
    }
}
