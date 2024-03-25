//
//  UserPreferences.swift
//  Bubly
//
//  Created by Valentin Mille on 3/10/24.
//

import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
final class UserPreferences {

    class Storage {
        @AppStorage("hapticFeedbackActivated") public var hapticFeedbackActivated: Bool = true
        @AppStorage("theme") public var theme: Theme = .main
        @AppStorage("isOnBoardingCompleted") public var isOnBoardingCompleted: Bool = false
        @AppStorage("didShowFirstPaywall") public var didShowFirstPaywall: Bool = false
        @AppStorage("isPremium") public var isPremium: Bool = false
        @AppStorage("shouldBlockWithPaywall") public var shouldBlockWithPaywall: Bool = false
        @AppStorage("processActionCount") public var reviewWorthyActionCount: Int = 0
        @AppStorage("lastVersionPromptedForReview") public var lastVersionPromptedForReview: String?
    }

    static let shared = UserPreferences()
    private let storage = Storage()

    var hapticFeedbackActivated: Bool {
      didSet {
        storage.hapticFeedbackActivated = hapticFeedbackActivated
      }
    }

    var theme: Theme {
      didSet {
        storage.theme = theme
      }
    }

    var isOnBoardingCompleted: Bool {
        didSet {
          storage.isOnBoardingCompleted = isOnBoardingCompleted
        }
    }

    var didShowFirstPaywall: Bool {
        didSet {
          storage.didShowFirstPaywall = didShowFirstPaywall
        }
    }

    var isPremium: Bool {
        didSet {
          storage.isPremium = isPremium
        }
    }
    
    var shouldBlockWithPaywall: Bool {
        didSet {
          storage.shouldBlockWithPaywall = shouldBlockWithPaywall
        }
    }

    var reviewWorthyActionCount: Int {
        didSet {
            storage.reviewWorthyActionCount = reviewWorthyActionCount
        }
    }

    var lastVersionPromptedForReview: String? {
        didSet {
            storage.lastVersionPromptedForReview = lastVersionPromptedForReview
        }
    }

    init() {
        hapticFeedbackActivated = storage.hapticFeedbackActivated
        didShowFirstPaywall = storage.didShowFirstPaywall
        theme = storage.theme
        isOnBoardingCompleted = storage.isOnBoardingCompleted
        isPremium = storage.isPremium
        shouldBlockWithPaywall = storage.shouldBlockWithPaywall
        reviewWorthyActionCount = storage.reviewWorthyActionCount
        lastVersionPromptedForReview = storage.lastVersionPromptedForReview
    }
}
