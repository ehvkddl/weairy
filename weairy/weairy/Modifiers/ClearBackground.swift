//
//  ClearBackground.swift
//  weairy
//
//  Created by do hee kim on 2024/03/24.
//

import SwiftUI

struct ClearBackground: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
    
}

struct ClearBackgroundModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            content
                .presentationBackground(.clear)
        } else {
            content
                .background(ClearBackground())
        }
    }
    
}

extension View {
    
    func clearBackground() -> some View {
        self.modifier(ClearBackgroundModifier())
    }
    
}
