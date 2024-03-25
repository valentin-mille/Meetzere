//
//  AppVersionManager.swift
//  Env
//
//  Created by Valentin Mille on 2/7/24.
//

import Foundation

public final class AppVersionManager {

    public func getAppBundleVersion() -> String? {
        // Get the current bundle version for the app
        let infoDictionaryKey = kCFBundleVersionKey as String
        return Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
    }
}
