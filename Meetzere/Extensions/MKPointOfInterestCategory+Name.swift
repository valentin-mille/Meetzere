//
//  MKPointOfInterestCategory+Name.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/21/24.
//

import Foundation
import MapKit

extension MKPointOfInterestCategory {

    static var supportedCategories: [MKPointOfInterestCategory] = [
        .airport,
        .bakery,
        .beach,
        .brewery,
        .cafe,
        .fitnessCenter,
        .foodMarket,
        .hotel,
        .library,
        .movieTheater,
        .museum,
        .nationalPark,
        .nightlife,
        .park,
        .publicTransport,
        .restaurant,
        .school,
        .stadium,
        .theater,
        .university,
        .winery,
        .zoo
    ]

    static var supportedCategoryNames: [String] = supportedCategories.map({ $0.name })

    var name: String {
        switch self {
        case .airport:
            return "Airport"
        case .amusementPark:
            return "Amusement Park"
        case .aquarium:
            return "Aquarium"
        case .atm:
            return "ATM"
        case .bakery:
            return "Bakery"
        case .bank:
            return "Bank"
        case .beach:
            return "Beach"
        case .brewery:
            return "Brewery"
        case .cafe:
            return "Cafe"
        case .campground:
            return "Campground"
        case .carRental:
            return "Car Rental"
        case .evCharger:
            return "EV Charger"
        case .fireStation:
            return "Fire Station"
        case .fitnessCenter:
            return "Fitness Center"
        case .foodMarket:
            return "Food Market"
        case .gasStation:
            return "Gas Station"
        case .hospital:
            return "Hospital"
        case .hotel:
            return "Hotel"
        case .laundry:
            return "Laundry"
        case .library:
            return "Library"
        case .marina:
            return "Marina"
        case .movieTheater:
            return "Movie Theater"
        case .museum:
            return "Museum"
        case .nationalPark:
            return "National Park"
        case .nightlife:
            return "Nightlife"
        case .park:
            return "Park"
        case .parking:
            return "Parking"
        case .pharmacy:
            return "Pharmacy"
        case .police:
            return "Police"
        case .postOffice:
            return "Post Office"
        case .publicTransport:
            return "Public Transport"
        case .restaurant:
            return "Restaurant"
        case .restroom:
            return "Restroom"
        case .school:
            return "School"
        case .stadium:
            return "Stadium"
        case .store:
            return "Store"
        case .theater:
            return "Theater"
        case .university:
            return "University"
        case .winery:
            return "Winery"
        case .zoo:
            return "Zoo"
        default:
            return ""
        }
    }
}
