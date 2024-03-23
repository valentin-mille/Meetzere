//
//  SettingsView.swift
//  Features
//
//  Created by Valentin Mille on 2/26/23.
//

import SwiftUI

private enum ExternalURL {
    static let URLTermsOfUsage =
        "https://humane-coriander-1a6.notion.site/Terms-of-service-5fa4852ada8d414692c4bf1c189e9204"
    static let URLPrivacyPolicy =
        "https://humane-coriander-1a6.notion.site/Privacy-Policy-35f60d629ece47faac477225ba10e2bf"
    static let URLHelpFAQ = "https://humane-coriander-1a6.notion.site/Help-FAQ-c2fdb202b91c4147a656044fce33fd4c"
    static let appStoreURL = "https://apps.apple.com/app/id6479580889"
    static let appStoreReviewURL = "\(ExternalURL.appStoreURL)?action=write-review"
}

@MainActor
public struct SettingsView: View {

    // MARK: - Private Properties

    @State private var routerPath = RouterPath()
    private let viewModel = SettingsViewModel()
    @Environment(\.colorScheme) var colorScheme
    @Environment(UserPreferences.self) var preferences

    // MARK: - Private Methods

    private func navigateToSheet(sheetDestination: SheetDestination) {
        routerPath.presentedSheet = sheetDestination
    }

    @MainActor private func navigateToPath(destination: RouterDestination) {
        routerPath.navigate(toDestination: destination)
    }

    var window: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            return nil
        }
        return window
    }

    // MARK: - View

    public var body: some View {
        NavigationStack(path: $routerPath.path) {
            @Bindable var userPreferences = preferences
            VStack(spacing: 0) {
                if !preferences.isPremium {
                    Section {
                        ButtonHaptic {
                            routerPath.presentedSheet = .paywall(onCompletion: {_ in
                                preferences.isPremium = true
                            })
                        } label: {
                            PremiumBannerView()
                        }
                    }
                    .padding()
                }
                List {
                    Section {
                        SettingSwitchRow(
                            title: "Haptics",
                            systemName: "iphone.gen2",
                            isOn: $userPreferences.hapticFeedbackActivated
                        )
                        .hapticTapGesture {
                            preferences.hapticFeedbackActivated.toggle()
                        }
                    }
                    Section {
                        SettingRow(
                            title: "Rate The App",
                            systemName: "star"
                        )
                        .hapticTapGesture {
                            AnalyticManager.shared.sendSignal(signalType: AnalyticEvent.didGoToAppStoreReview)
                            UIApplication.shared.open(URL(string: ExternalURL.appStoreReviewURL)!)
                        }
                        ShareLink(item: URL(string: ExternalURL.appStoreURL)!) {
                            SettingRow(
                                title: "Share \(SettingsViewModel.getAppName())",
                                systemName: "square.and.arrow.up"
                            )
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                        }
                    }
                    Section {
                        SettingRow(
                            title: "Terms Of Usage",
                            systemName: "book"
                        )
                        .hapticTapGesture {
                            navigateToSheet(sheetDestination: .webView(ExternalURL.URLTermsOfUsage))
                        }
                        SettingRow(
                            title: "Privacy Policy",
                            systemName: "lock.fill"
                        )
                        .hapticTapGesture {
                            navigateToSheet(sheetDestination: .webView(ExternalURL.URLPrivacyPolicy))
                        }
//                        SettingRow(
//                            title: "help & FAQ",
//                            systemName: "questionmark.circle"
//                        )
//                        .hapticTapGesture {
//                            navigateToSheet(sheetDestination: .webView(ExternalURL.URLHelpFAQ))
//                        }
                    } footer: {
                        AppFooterView()
                            .padding()
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .onAppear {
                Task {
//                    preferences.isPremium = await InAppPurchaseManager.shared.hasPremiumAcces()
                }
            }
            .background(.mainBackground)
            .presentationDetents([.large])
            .presentationBackground(.thinMaterial)
            .presentationCornerRadius(16)
            .presentationDragIndicator(.visible)
            .withSheetDestination(sheetDestination: $routerPath.presentedSheet)
            .withAppRouter()
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
        .environment(UserPreferences.shared)
}
