//
//  SettingsViewModel.swift
//
//
//  Created by Valentin Mille on 12/10/23.
//

import Foundation

final class SettingsViewModel {

    // MARK: - Exposed Methods

    func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] {
            return "Version \(appVersion)"
        }
        return ""
    }

    static func getAppName() -> String {
        if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            return appName.capitalized
        }
        return ""
    }

}
