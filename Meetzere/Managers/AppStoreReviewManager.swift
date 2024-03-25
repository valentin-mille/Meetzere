//
//  File.swift
//
//
//  Created by Valentin Mille on 2/7/24.
//

import Foundation
import StoreKit
import SwiftUI

@MainActor
final class AppStoreReviewManager {

    static let shared = AppStoreReviewManager()
    private let minimumActionCount = 2
    private let versionManager = AppVersionManager()
    private let preferences = UserPreferences.shared

    public init() {

    }

    public func shouldShowAppStoreReview() -> Bool {
        guard let version = versionManager.getAppBundleVersion() else {
            return false
        }

        if preferences.reviewWorthyActionCount >= minimumActionCount
            && (preferences.lastVersionPromptedForReview == nil || preferences.lastVersionPromptedForReview != version)
        {
            preferences.lastVersionPromptedForReview = version
            preferences.reviewWorthyActionCount = 0
            return true
        }
        return false
    }

    public func incrementReviewWorthyActionCount() {
        preferences.reviewWorthyActionCount += 1
    }
}
