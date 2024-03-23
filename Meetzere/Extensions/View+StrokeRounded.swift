//
//  View+StrokeRounded.swift
//  Bubly
//
//  Created by Valentin Mille on 3/6/24.
//

import SwiftUI

extension View {
    func strokeRounded(cornerRadius: CGFloat = Styles.Radius.radius2x2Quarter) -> some View {
        self.modifier(AnimationBouncing(cornerRadius: cornerRadius))
    }
}

private struct AnimationBouncing: ViewModifier {

    private let cornerRadius: CGFloat

    init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
    }

    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.tint.opacity(0.2))
            }

    }
}
