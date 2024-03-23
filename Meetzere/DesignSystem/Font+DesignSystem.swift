//
//  Font+DesignSystem.swift
//  Bubly
//
//  Created by Valentin Mille on 3/5/24.
//

import SwiftUI

extension Font {
    static let textTitle = Font.system(.title, design: .rounded)
    static let textBody = Font.system(.body, design: .rounded)
    static let textSecondary = Font.system(.subheadline, design: .rounded)
    static let button = Font.system(size: Styles.Size.size2x, design: .rounded)
}

