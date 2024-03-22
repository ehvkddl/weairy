//
//  OnChange.swift
//  weairy
//
//  Created by do hee kim on 2024/03/22.
//

import SwiftUI

struct OnChangeWithCondition<V: Equatable>: ViewModifier {
    
    let value: V
    let completion: (V) -> Void
    
    init(
        value: V,
        completion: @escaping (V) -> Void
    ) {
        self.value = value
        self.completion = completion
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .onChange(of: value) { oldValue, newValue in
                    completion(newValue)
                }
        } else {
            content
                .onChange(of: value, perform: { newValue in
                    completion(newValue)
                })
        }
    }
    
}

extension View {
    func onChangeWithCondition<V: Equatable>(of value: V, completion: @escaping (V) -> ()) -> some View {
        modifier(OnChangeWithCondition(value: value, completion: completion))
    }
}
