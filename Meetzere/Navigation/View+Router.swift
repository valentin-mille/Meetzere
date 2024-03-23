//
//  AppRouter.swift
//  Features
//
//  Created by Valentin Mille on 7/14/23.
//

import SwiftUI

@MainActor
extension View {
    func withAppRouter() -> some View {
        navigationDestination(for: RouterDestination.self) { destination in
            switch destination {
            case .mapArea(let meetingRequest):
                MapAreaView(meetingRequest: meetingRequest)
            }
        }
    }
}
