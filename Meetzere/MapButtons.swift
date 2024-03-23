//
//  BeantownButtons.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/19/24.
//

import SwiftUI
import MapKit

struct MapButtons: View {
    @Binding var position: MapCameraPosition
    @Binding var searchResults: [MKMapItem]
    var visibleRegion: MKCoordinateRegion?

    var body: some View {
        HStack {
            Button {
                search(for: "restaurant")
            } label: {
                Label("Restaurants", systemImage: "fork.knife.circle.fill")
            }
            .buttonStyle(.borderedProminent)
            Button {
                search(for: "brewery")
            } label: {
                Label ("Brewery", systemImage: "mug")
            }
            .buttonStyle(.borderedProminent)
            Button {
                position = .region(.boston)
            } label: {
                Label ("Boston", systemImage: "building.2")
            }
            .buttonStyle(.bordered)
            Button {
                position = .region(.paris)
            } label: {
                Label ("Paris", systemImage: "heart.circle.fill")
            }
            .buttonStyle(.bordered)
        }
        .labelStyle(.iconOnly)
    }

    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = visibleRegion ?? MKCoordinateRegion(
            center: .parking,
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)
        )

        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}

#Preview {
    MapButtons(
        position: .constant(.region(.boston)),
        searchResults: .constant([]),
        visibleRegion: nil
    )
}
