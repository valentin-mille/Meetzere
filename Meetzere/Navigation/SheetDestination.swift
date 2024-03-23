//
//  SheetDestination.swift
//  GentleEat
//
//  Created by Valentin Mille on 3/1/24.
//

import Foundation
import SwiftData
import RevenueCatUI
import MapKit

enum SheetDestination: Identifiable {
    case settings
    case mapAddressSelection(String, (MKMapItem) -> Void)
    case webView(String)
    case shareURL(String)
    case paywall(onCompletion: PurchaseOrRestoreCompletedHandler)

    public var id: String {
        switch self {
        case .settings:
            return "settings"
        case .mapAddressSelection:
            return "mapAddressSelection"
        case .webView:
            return "webView"
        case .shareURL:
            return "shareURL"
        case .paywall:
            return "paywall"
        }
    }
}

// MARK: - Equatable

extension SheetDestination: Equatable {
    public static func == (lhs: SheetDestination, rhs: SheetDestination) -> Bool {
        lhs.id == rhs.id
    }
}
