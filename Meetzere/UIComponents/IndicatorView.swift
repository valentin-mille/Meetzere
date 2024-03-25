//
//  IndicatorView.swift
//  SharedViews
//
//  Created by Valentin Mille on 2/19/23.
//

import SwiftUI

private enum Constants {
    static let width: CGFloat = 10
    static let height: CGFloat = 10
    static let widthExpanded: CGFloat = Self.width * 2
}

public struct IndicatorView: View {
    let count: Int
    @Binding var currentIndex: Int
    @Environment(UserPreferences.self) private var preferences

    public init(count: Int, currentIndex: Binding<Int>) {
        self.count = count
        self._currentIndex = currentIndex
    }

    private func isCurrentIndex(index: Int) -> Bool {
        return currentIndex == index
    }

    private func getWidth(index: Int) -> CGFloat {
        if isCurrentIndex(index: index) {
            return Constants.widthExpanded
        }
        return Constants.width
    }

    public var body: some View {
        HStack {
            ForEach(0..<count, id: \.self) { index in
                Capsule()
                    .foregroundStyle(isCurrentIndex(index: index) ? preferences.theme.tint : preferences.theme.tint.opacity(0.2))
                    .frame(width: getWidth(index: index), height: Constants.height)
            }
        }
    }
}

#Preview {
    IndicatorView(count: 3, currentIndex: .constant(1))
        .previewLayout(.sizeThatFits)
        .environment(UserPreferences.shared)
}
