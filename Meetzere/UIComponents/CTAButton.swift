//
//  CTAButton.swift
//  Bubly
//
//  Created by Valentin Mille on 3/7/24.
//

import Foundation
import SwiftUI

struct CTAButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(UserPreferences.self) private var preferences

    private func getColor(color: Color) -> Color {
        if isEnabled {
            return color
        }
        return color.opacity(0.5)
    }

    @MainActor
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(getColor(color: .white))
            .background(getColor(color: preferences.theme.tint))
            .clipShape(RoundedRectangle(cornerRadius: Styles.Radius.radius2x2Quarter))
            .font(.system(size: Styles.Size.size3x, weight: .semibold, design: .rounded))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(
                .interpolatingSpring(
                    mass: 1,
                    stiffness: 100,
                    damping: 11,
                    initialVelocity: 10
                )
                .delay(0),
                value: configuration.isPressed
            )
    }
}

extension ButtonStyle where Self == CTAButton {
    static var CTAButton: CTAButton {
        Meetzere.CTAButton()
    }
}

#Preview {
    Button(action: {}, label: {
        Text("Save Contact")
    })
    .environment(UserPreferences.shared)
    .disabled(false)
    .tint(.tintRed)
    .buttonStyle(.CTAButton)
    .padding()
}
