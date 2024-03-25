//
//  MeetzereApp.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/19/24.
//

import SwiftUI
import SwiftData
import RevenueCat

@MainActor
@main
struct MeetzereApp: App {
    @State private var preferences = UserPreferences.shared

    init() {
        AnalyticManager.shared.configure()
        Purchases.configure(withAPIKey: SecretLoader.loadSecret(secretName: "REVENUE_CAT_API_KEY"))
    }

    var body: some Scene {
        WindowGroup {
            if preferences.isOnBoardingCompleted {
                MeetingFormView()
                    .environment(preferences)
                    .tint(preferences.theme.tint)
            } else {
                OnBoardingView()
                    .environment(preferences)
                    .tint(preferences.theme.tint)
            }
        }
    }
}
