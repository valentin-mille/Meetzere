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
        @AppStorage("hapticFeedbackActivated") public var hapticFeedbackActivated: Bool = false
        @AppStorage("soundActivated") public var soundActivated: Bool = false
        @AppStorage("theme") public var theme: Theme = .main
        @AppStorage("isOnBoardingCompleted") public var isOnBoardingCompleted: Bool = false
        @AppStorage("isPremium") public var isPremium: Bool = false
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

    var soundActivated: Bool {
      didSet {
        storage.soundActivated = soundActivated
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

    var isPremium: Bool {
        didSet {
          storage.isPremium = isPremium
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
        soundActivated = storage.soundActivated
        theme = storage.theme
        isOnBoardingCompleted = storage.isOnBoardingCompleted
        isPremium = storage.isPremium
        reviewWorthyActionCount = storage.reviewWorthyActionCount
        lastVersionPromptedForReview = storage.lastVersionPromptedForReview
    }
}
