//
//  HapticManager.swift
//  Features
//
//  Created by Valentin Mille on 7/14/23.
//

import CoreHaptics
import UIKit

final class HapticManager {
    static let shared: HapticManager = .init()

    enum HapticType {
        case tapGesture
        case sheetSlide
    }

    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private let notificationGenerator = UINotificationFeedbackGenerator()

    private init() {
        selectionGenerator.prepare()
        impactGenerator.prepare()
    }

    @MainActor
    func playHaptic(of type: HapticType) {
        var supportsHaptics: Bool {
            CHHapticEngine.capabilitiesForHardware().supportsHaptics
        }
        guard supportsHaptics,
              UserPreferences.shared.hapticFeedbackActivated == true
        else { return }

        switch type {
        case .tapGesture:
            impactGenerator.impactOccurred()
        case .sheetSlide:
            selectionGenerator.selectionChanged()
        }
    }
}
