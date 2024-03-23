//
//  HapticButton.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/23/24.
//

import SwiftUI

struct ButtonHaptic<Label: View>: View {

    typealias ButtonActionType = () -> Void

    private let action: ButtonActionType
    private let label: Label

    init(action: @escaping ButtonActionType, @ViewBuilder label: () -> Label) {
        self.action = action
        self.label = label()
    }

    var body: some View {
        Button(action: {
            HapticManager.shared.playHaptic(of: .tapGesture)
            
            action()
        }, label: {
            label
        })
    }
}

#Preview {
    ButtonHaptic {

    } label: {
       Text("Start")
    }
    .buttonStyle(.CTAButton)
    .padding()
    .environment(UserPreferences.shared)
}
