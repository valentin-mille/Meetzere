//
//  View+HapticTapGesture.swift
//  GentleEat
//
//  Created by Valentin Mille on 3/1/24.
//

import Foundation
import SwiftUI

extension View {
    /// A convenience method for applying `TouchDownUpEventModifier.`
    func hapticTapGesture(callback: @escaping () -> Void) -> some View {
        self.modifier(HapticTapGestureModifier(callback: callback))
    }
}

struct HapticTapGestureModifier: ViewModifier {

    var callback: () -> Void

    func body(content: Content) -> some View {
        content
            .onTapGesture {
                HapticManager.shared.playHaptic(of: .tapGesture)
                callback()
            }
    }
}
