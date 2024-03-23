//
//  MeetzereApp.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/19/24.
//

import SwiftUI
import SwiftData

@MainActor
@main
struct MeetzereApp: App {
    @State private var preferences = UserPreferences.shared
    private var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    init() {
        AnalyticManager.shared.configure()
//        Purchases.configure(withAPIKey: SecretLoader.loadSecret(secretName: "REVENUE_CAT_API_KEY"))
    }

    var body: some Scene {
        WindowGroup {
            MeetingFormView()
                .environment(preferences)
                .tint(preferences.theme.tint)
        }
        .modelContainer(sharedModelContainer)
    }
}
