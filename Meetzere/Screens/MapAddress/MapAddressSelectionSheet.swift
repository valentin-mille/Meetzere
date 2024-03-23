//
//  MapAddressSelectionSheet.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/21/24.
//

import SwiftUI
import MapKit

struct MapAddressSelectionSheet: View {
    @State private var searchQuery: String = ""
    @State private var locationService = LocationService(completer: .init())
    var placeholder: String
    @Binding var searchResults: [MKMapItem]

    private func didTapOnCompletion(_ completion: SearchCompletions) {
        Task {
            if let singleLocation = try? await locationService.search(with: "\(completion.title) \(completion.subTitle)").first {
                searchResults = [singleLocation]
            }
        }
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(placeholder, text: $searchQuery)
                    .textFieldStyle(.inputStyle)
                    .autocorrectionDisabled()
                    .onSubmit {
                        Task {
                            searchResults = (try? await locationService.search(with: searchQuery)) ?? []
                        }
                    }
            }
            Spacer()
            List {
                ForEach(locationService.completions) { completion in
                    ButtonHaptic(action: { didTapOnCompletion(completion) }) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(completion.title)
                                .font(.headline)
                                .fontDesign(.rounded)
                            Text(completion.subTitle)
                        }
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .onChange(of: searchQuery) {
            locationService.update(queryFragment: searchQuery)
        }
        .padding()
        .interactiveDismissDisabled()
        .presentationDetents([.height(200), .large])
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
        .presentationCornerRadius(Styles.Radius.radius2x2Quarter)
    }
}

#Preview {
    MapAddressSelectionSheet(placeholder: "Select Friend Place", searchResults: .constant([]))
}
