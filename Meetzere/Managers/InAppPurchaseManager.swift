//
//  InAppPurchaseManager.swift
//
//
//  Created by Valentin Mille on 2/21/24.
//

import Foundation
import RevenueCat

public final class InAppPurchaseManager {

    public static let shared = InAppPurchaseManager()

    public init() {

    }

    public func hasPremiumAcces() async -> Bool {
        do {
            let customerInfo = try await Purchases.shared.customerInfo()
            return customerInfo.entitlements.active.isEmpty == false
        } catch {
            return false
        }
    }
}
