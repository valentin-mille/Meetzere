//
//  AnalyticManager.swift
//  Analytics
//
//  Created by Valentin Mille on 2/7/24.
//

import Foundation
import TelemetryClient

public final class AnalyticManager {

    public static let shared = AnalyticManager()

    public init() {
    }

    public func configure() {
        let configuration = TelemetryManagerConfiguration(
            appID: SecretLoader.loadSecret(secretName: "TELEMETRY_APP_ID")
        )
        TelemetryManager.initialize(with: configuration)
    }

    public func sendSignal(signalType: String, data: [String: String] = [:]) {
        TelemetryManager.send(signalType, with: data)
    }
}
