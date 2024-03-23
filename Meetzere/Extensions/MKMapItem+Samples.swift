//
//  MKMapItem+Samples.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/21/24.
//

import Foundation
import Contacts
import MapKit

extension MKMapItem {
    static func previewUserLocation() -> MKMapItem {
        let coordinates = CLLocationCoordinate2D(
            latitude: .init(floatLiteral: 48.8314891),
            longitude: .init(floatLiteral: 2.304093)
        )
        let address = [
            CNPostalAddressStreetKey: "15 Rue de Chambéry",
            CNPostalAddressCityKey: "Paris",
            CNPostalAddressPostalCodeKey: "75015",
            CNPostalAddressISOCountryCodeKey: "FR"
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: address)
        let fifteenChamberyParis = MKMapItem(placemark: placemark)
        fifteenChamberyParis.timeZone = TimeZone(identifier: "Europe/Paris")
        fifteenChamberyParis.name = "15 Rue de Chambéry"
        return fifteenChamberyParis
    }

    static func previewFriendLocation() -> MKMapItem {
        let coordinates = CLLocationCoordinate2D(
            latitude: .init(floatLiteral: 48.8742811),
            longitude: .init(floatLiteral: 2.3862137)
        )
        let address = [
            CNPostalAddressStreetKey: "100 Rue de Belleville",
            CNPostalAddressCityKey: "Paris",
            CNPostalAddressPostalCodeKey: "75020",
            CNPostalAddressISOCountryCodeKey: "FR"
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: address)
        let fifteenChamberyParis = MKMapItem(placemark: placemark)
        fifteenChamberyParis.timeZone = TimeZone(identifier: "Europe/Paris")
        fifteenChamberyParis.name = "100 Rue de Belleville"
        return fifteenChamberyParis
    }

//    static func previewArea() -> MKMapItem {
//        let coordinates = CLLocationCoordinate2D(
//            latitude: .init(floatLiteral: 48.8742811),
//            longitude: .init(floatLiteral: 2.3862137)
//        )
//        let address = [
//            CNPostalAddressStreetKey: "100 Rue de Belleville",
//            CNPostalAddressCityKey: "Paris",
//            CNPostalAddressPostalCodeKey: "75020",
//            CNPostalAddressISOCountryCodeKey: "FR"
//        ]
//        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: address)
//        let fifteenChamberyParis = MKMapItem(placemark: placemark)
//        fifteenChamberyParis.timeZone = TimeZone(identifier: "Europe/Paris")
//        fifteenChamberyParis.name = "100 Rue de Belleville"
//        return fifteenChamberyParis
//    }
}
