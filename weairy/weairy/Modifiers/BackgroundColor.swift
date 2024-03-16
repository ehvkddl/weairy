//
//  BackgroundColor.swift
//  weairy
//
//  Created by do hee kim on 2024/03/15.
//

import SwiftUI

struct BackgroundColorModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        ZStack {
            color
            content
        }
        .ignoresSafeArea()
    }
}

extension View {
    func backgroundColor(_ color: Color) -> some View {
        modifier(BackgroundColorModifier(color: color))
    }
}
