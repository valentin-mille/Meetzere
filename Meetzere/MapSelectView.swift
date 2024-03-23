//
//  MapSelectView.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/20/24.
//

import SwiftUI
import MapKit
import Observation

final class LocationManager: NSObject, Observable, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    var locationStatus: CLAuthorizationStatus?
    var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        print(#function, location)
    }
}

struct MapSelectView: View {
    @State var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .automatic
    @State private var searchResults: [MKMapItem] = []
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    @State private var visibleRegion: MKCoordinateRegion?

    var body: some View {
        Map(position: $position, selection: $selectedResult) {
            //                Annotation("Parking", coordinate: .parking) {
            //                    ZStack {
            //                        RoundedRectangle(cornerRadius: 5)
            //                            .fill(.background)
            //                        RoundedRectangle(cornerRadius: 5)
            //                            .stroke(.secondary, lineWidth: 5)
            //                        Image (systemName: "car")
            //                            .padding (5)
            //                    }
            //                }
            //                .annotationTitles(.hidden)
            ForEach(searchResults, id: \.self) { result in
                Marker(item: result)
            }
            .annotationTitles(.hidden)
            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
            UserAnnotation()
        }
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    if let selectedResult {
                        ItemInfoView(selectedResult: selectedResult, route: route)
                            .frame(height: 128)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding([.top, .horizontal])
                    }
                    MapButtons(
                        position: $position,
                        searchResults: $searchResults,
                        visibleRegion: visibleRegion
                    )
                    .padding(.top)
                }
                Spacer()
            }
            .background (.thinMaterial)
        }
        .onChange(of: searchResults) {
            position = .automatic
        }
        .onChange(of: selectedResult) {
            getDirections()
        }
        .onMapCameraChange { context in
            visibleRegion = context.region
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
    }

    func getDirections() {
        route = nil
        guard let selectedResult else { return }
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: .parking))
        request.destination = selectedResult

        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }
}

#Preview {
    MapSelectView()
}
