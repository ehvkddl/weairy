//
//  OnChange.swift
//  weairy
//
//  Created by do hee kim on 2024/03/22.
//

import SwiftUI

struct OnChange: ViewModifier {
    @Environment (\.scenePhase) var scenePhase
    
    let activeCompletion: () -> Void
    
    init(activeCompletion: @escaping () -> Void) {
        self.activeCompletion = activeCompletion
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .onChange(of: scenePhase) { oldScenePhase, newScenePhase in
                    handleActiveState(newScenePhase)
                }
        } else {
            content
                .onChange(of: scenePhase) { newScenePhase in
                    handleActiveState(newScenePhase)
                }
        }
    }
    
    func handleActiveState(_ newScenePhase: ScenePhase) {
        switch newScenePhase {
        case .active:
            activeCompletion()
        default:
            print("Unexpected value")
        }
    }
}

extension View {
    func onChange(activeCompletion: @escaping () -> ()) -> some View {
        modifier(OnChange(activeCompletion: activeCompletion))
    }
}
