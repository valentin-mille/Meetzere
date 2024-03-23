//
//  TransportType.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/22/24.
//

import Foundation
import MapKit

enum TransportType: Int, CaseIterable {
    case automobile
    case publicTransport
    case walking

    static var types: [String] {
        return allCases.map({ $0.name })
    }

    var name: String {
        switch self {
        case .automobile:
            return "Automobile"
        case .publicTransport:
            return "Transit"
        case .walking:
            return "Walking"
        }
    }

    var directionTransportType: MKDirectionsTransportType {
        switch self {
        case .automobile:
            return .automobile
        case .publicTransport:
            return .transit
        case .walking:
            return .walking
        }
    }

    var systemeName: String {
        switch self {
        case .automobile:
            return "car"
        case .publicTransport:
            return "tram.fill"
        case .walking:
            return "figure.walk"
        }
    }
}
