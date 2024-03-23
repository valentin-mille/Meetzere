//
//  AppFooterViewModel.swift
//
//
//  Created by Valentin Mille on 2/23/24.
//

import Foundation

final class AppFooterViewModel {
    func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] {
            return "Version \(appVersion)"
        }
        return ""
    }

    func getAppName() -> String {
        if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            return appName.capitalized
        }
        return ""
    }
}
