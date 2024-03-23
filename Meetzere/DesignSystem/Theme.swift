//
//  Theme.swift
//  Bubly
//
//  Created by Valentin Mille on 3/5/24.
//

import Foundation
import SwiftUI

enum Theme: String {
    case main = "Main"

    var tint: Color {
        switch self {
        case .main:
            return .tintMain
        }
    }
}
