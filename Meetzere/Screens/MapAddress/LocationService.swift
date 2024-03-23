//
//  LocationService.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/21/24.
//

import Foundation
import MapKit

struct SearchCompletions: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
}

@Observable
final class LocationService: NSObject, MKLocalSearchCompleterDelegate {
    private let completer: MKLocalSearchCompleter
    private let resultType: MapResultType = .address

    var completions = [SearchCompletions]()

    init(completer: MKLocalSearchCompleter) {
        self.completer = completer
        super.init()
        self.completer.delegate = self
    }

    func update(queryFragment: String) {
        completer.resultTypes = resultType.completionType
        completer.queryFragment = queryFragment
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completions = completer.results.map { completion in
            return SearchCompletions(
                title: completion.title,
                subTitle: completion.subtitle
            )
        }
    }

    func search(with query: String) async throws -> [MKMapItem] {
        let mapKitRequest = MKLocalSearch.Request()
        mapKitRequest.naturalLanguageQuery = query
        mapKitRequest.resultTypes = resultType.searchType
        let search = MKLocalSearch(request: mapKitRequest)

        let response = try await search.start()

        return response.mapItems
    }
}
