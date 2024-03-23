//
//  View+Shadow.swift
//  Bubly
//
//  Created by Valentin Mille on 3/6/24.
//

import SwiftUI

extension View {
    public func dropShadow() -> some View {
        modifier(ShadowCardStyle())
    }
}

struct ShadowCardStyle: ViewModifier {

    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .shadow(color: colorScheme == .dark ? .black : .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}
