//
//  UIScreen+current.swift
//
//
//  Created by Valentin Mille on 2/21/24.
//

import Foundation
import SwiftUI

extension UIWindow {
    fileprivate static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }

    ///
    /// From https://stackoverflow.com/questions/62652555/how-to-get-uiwindow-value-in-ios-14-main-file
    ///
    /// guard let scene = UIApplication.shared.connectedScenes.first,
    ///       let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
    ///       let window = windowSceneDelegate.window else {
    ///     return nil
    /// }
    /// return window
}

extension UIScreen {
    public static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
