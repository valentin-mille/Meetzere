//
//  MapResultType.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/21/24.
//

import Foundation
import MapKit

enum MapResultType {
    case pointOfInterest
    case address

    var completionType: MKLocalSearchCompleter.ResultType {
        switch self {
        case .address:
            return .address
        case .pointOfInterest:
            return .pointOfInterest
        }
    }

    var searchType: MKLocalSearch.ResultType {
        switch self {
        case .pointOfInterest:
            return .pointOfInterest
        case .address:
            return .address
        }
    }
}
