//
//  RouterPath.swift
//  Features
//
//  Created by Valentin Mille on 7/16/23.
//

import Foundation
import Observation

@MainActor
@Observable
final class RouterPath {
    var path: [RouterDestination] = []
    var presentedSheet: SheetDestination?

    init() {}

    @MainActor
    func navigate(toDestination: RouterDestination) {
        path.append(toDestination)
    }
}
