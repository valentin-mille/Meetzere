//
//  SecretLoader.swift
//  GentleEat
//
//  Created by Valentin Mille on 3/1/24.
//

import Foundation

public struct SecretLoader {

    // MARK: - Exposed Methods

    public static func loadSecret(secretName: String) -> String {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist") {
            let secret = NSDictionary(contentsOfFile: path)
            return secret?[secretName] as? String ?? ""
        }
        return ""
    }
}
