//
//  MapAddressSelection.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/20/24.
//

import SwiftUI
import MapKit
import Combine

struct MapAddressSelection: View {

    typealias AddressSelectedCallbackType = (MKMapItem) -> Void

    @State var searchQuery: String = ""
    @State private var position: MapCameraPosition = .automatic
    @State private var selectedResult: MKMapItem?
    @State private var searchResults: [MKMapItem] = []
    @Environment(\.dismiss) private var dismiss
    @State private var showAddressSheet: Bool = true
    private let didSelectAddress: AddressSelectedCallbackType
    private let placeholder: String
    @Namespace private var mapScope
    @Environment(\.colorScheme) private var scheme

    init(placeholder: String, didSelectAddress: @escaping AddressSelectedCallbackType) {
        self.placeholder = placeholder
        self.didSelectAddress = didSelectAddress
    }

    var body: some View {
        Map(position: $position, selection: $selectedResult, scope: mapScope) {
            ForEach(searchResults, id: \.self) { result in
                Marker(item: result)
            }
            .annotationTitles(.hidden)
            UserAnnotation()
        }
        .mapStyle(.standard(elevation: .realistic))
        .overlay(alignment: .topLeading) {
            VStack(alignment: .leading) {
                MapScaleView(scope: mapScope)
            }
             .padding(10)
       }
        .overlay(alignment: .topTrailing) {
            VStack(alignment: .trailing) {
                ButtonHaptic {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .fontWeight(.bold)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                        .padding(15)
                }
                .foregroundStyle(.tintMain)
                .background(.primaryComponent)
                .clipShape(Circle())
                MapUserLocationButton(scope: mapScope)
                MapCompass(scope: mapScope)
            }
            .padding(10)
            .buttonBorderShape(.circle)
        }
        .mapScope(mapScope)
        .safeAreaInset(edge: .bottom) {
            VStack {
                if let selectedResult {
                    MapLookAroundView(selectedResult: selectedResult)
                        .frame(height: 128)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding([.top, .horizontal])
                    ButtonHaptic {
                        didSelectAddress(selectedResult)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .buttonStyle(.CTAButton)
                    .padding()
                }
            }
            .background(.thinMaterial)
        }
        .onChange(of: selectedResult) {
            let isSelected = selectedResult == nil
            showAddressSheet = isSelected
            if !isSelected {
                position = .automatic
            }
        }
        .onChange(of: searchResults) {
            if let firstResult = searchResults.first, searchResults.count == 1 {
                selectedResult = firstResult
            }
        }
        .sheet(isPresented: $showAddressSheet) {
            MapAddressSelectionSheet(placeholder: placeholder, searchResults: $searchResults)
        }
    }
}

#Preview {
    NavigationStack {
        HStack {

        }
        .sheet(isPresented: .constant(true)) {
            MapAddressSelection(placeholder: "Select Friend Place", didSelectAddress: { _ in })
                .navigationTitle("Friend Location")
                .environment(UserPreferences.shared)
        }
    }
}
