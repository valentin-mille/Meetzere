//
//  View+Sheet.swift
//  Features
//
//  Created by Valentin Mille on 7/16/23.
//

import SwiftUI
import RevenueCatUI

@MainActor
extension View {
    func withSheetDestination(sheetDestination: Binding<SheetDestination?>) -> some View {
        sheet(item: sheetDestination) { destination in
            switch destination {
            case .settings:
                NavigationStack {
                    SettingsView()
                        .presentationDetents([.large])
                        .presentationBackground(.thinMaterial)
                        .presentationCornerRadius(16)
                        .presentationDragIndicator(.visible)
                        .navigationBarTitleDisplayMode(.inline)
                }
            case .mapAddressSelection(let placeholder, let didSelectAddress):
                MapAddressSelection(placeholder: placeholder, didSelectAddress: didSelectAddress)
            case .webView(let urlString):
                WebView(URLString: urlString)
                    .presentationDragIndicator(.visible)
            case .shareURL(let url):
                ShareLink(item: URL(string: url)!)
            case .paywall(let onPurchaseCompleted):
                PaywallView(displayCloseButton: true)
                    .presentationDragIndicator(.visible)
                    .onPurchaseCompleted({ customerInfo in
                        onPurchaseCompleted(customerInfo)
                    })
                    .onAppear {
                        AnalyticManager.shared.sendSignal(signalType: AnalyticEvent.didShowPaywall)
                    }
            }
        }
    }
}
