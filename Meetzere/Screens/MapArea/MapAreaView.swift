//
//  MapAreaView.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/21/24.
//

import SwiftUI
import MapKit

@Observable
final class MapTravelInfos {
    let location: MKMapItem
    let transportType: TransportType
    var route: MKRoute?
    var timeETA: Double?
    var travelTime: String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        if let route {
            return formatter.string(from: route.expectedTravelTime)
        } else if let timeETA {
            return formatter.string(from: timeETA)
        }
        return nil
    }

    init(location: MKMapItem, transportType: TransportType, route: MKRoute? = nil, timeETA: Double? = nil) {
        self.location = location
        self.transportType = transportType
        self.route = route
        self.timeETA = timeETA
    }

    @MainActor
    func updateRouteETA(with selectedResult: MKMapItem?) {
        guard let selectedResult else { return }
        if transportType == .publicTransport {
            Task {
                let response = await getETA(selectedResult: selectedResult, location: location, transportType: transportType)
                timeETA = response?.expectedTravelTime
            }
        } else {
            Task {
                route = await getDirection(selectedResult: selectedResult, location: location, transportType: transportType)
            }
        }
    }

    func resetInfos() {
        route = nil
        timeETA = nil
    }

    private func getETA(selectedResult: MKMapItem, location: MKMapItem, transportType: TransportType) async -> MKDirections.ETAResponse? {
        let request = MKDirections.Request()
        request.source = location
        request.destination = selectedResult
        request.transportType = transportType.directionTransportType

        let directions = MKDirections(request: request)
        let response = try? await directions.calculateETA()
        return response
    }

    private func getDirection(selectedResult: MKMapItem, location: MKMapItem, transportType: TransportType) async -> MKRoute? {
        let request = MKDirections.Request()
        request.source = location
        request.destination = selectedResult
        request.transportType = transportType.directionTransportType

        let directions = MKDirections(request: request)
        let response = try? await directions.calculate()
        return response?.routes.first
    }
}

extension MapTravelInfos {
    static let previewUser = MapTravelInfos(location: MeetingRequest.preview.userLocation, transportType: MeetingRequest.preview.userTransportType)
    static let previewFriend = MapTravelInfos(location: MeetingRequest.preview.friendLocation, transportType: MeetingRequest.preview.friendTransportType)
}

struct MapTravelInfoView: View {
    private let locationDescription: String
    private let locationSystemName: String
    private let travelInfos: MapTravelInfos

    init(
        locationDescription: String,
        locationSystemName: String,
        travelInfos: MapTravelInfos
    ) {
        self.locationDescription = locationDescription
        self.locationSystemName = locationSystemName
        self.travelInfos = travelInfos
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                Label {
                    Text(locationDescription)
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundStyle(.textPrimary)
                } icon: {
                    Image(systemName: locationSystemName)
                }
                Text(travelInfos.location.name ?? "--")
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(1)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.textPrimary)
            }
            if let travelTime = travelInfos.travelTime {
                VStack(alignment: .leading) {
                    Label {
                        Text("Travel Time")
                            .lineLimit(1)
                            .font(.caption)
                            .foregroundStyle(.textPrimary)
                    } icon: {
                        Image(systemName: travelInfos.transportType.systemeName)
                    }
                    VStack(alignment: .leading) {
                        Text(travelTime)
                            .lineLimit(1)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.textPrimary)
                        if travelInfos.transportType == .publicTransport {
                            Text("Route preview not supported")
                                .lineLimit(1)
                                .font(.caption2)
                                .fontWeight(.regular)
                                .foregroundStyle(.tintRed)
                        }
                    }
                }
            }
        }
    }
}

struct MapInfoSheet: View {
    static private let smallDetent = PresentationDetent.fraction(0.3)
    static private let mediumDetent = PresentationDetent.fraction(0.6)
    static private let largeDetent = PresentationDetent.large

    private let meetingRequest: MeetingRequest
    private let selectedResult: MKMapItem?
    private let userTravelInfos: MapTravelInfos
    private let friendTravelInfos: MapTravelInfos
    @Binding private var searchResults: [MKMapItem]
    private let visibleRegion: MKCoordinateRegion?
    @State private var settingsDetent = Self.smallDetent
    @State private var shouldExpandInfos = true

    init(
        meetingRequest: MeetingRequest,
        selectedResult: MKMapItem?,
        userTravelInfos: MapTravelInfos,
        friendTravelInfos: MapTravelInfos,
        searchResults: Binding<[MKMapItem]>,
        visibleRegion: MKCoordinateRegion?
    ) {
        self.meetingRequest = meetingRequest
        self.selectedResult = selectedResult
        self.userTravelInfos = userTravelInfos
        self.friendTravelInfos = friendTravelInfos
        self._searchResults = searchResults
        self.visibleRegion = visibleRegion
    }


    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        if let visibleRegion {
            request.region = visibleRegion
        }
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            if let selectedResult, shouldExpandInfos {
                MapLookAroundView(selectedResult: selectedResult)
                    .frame(height: 128)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding([.top, .horizontal])
                    .transition(.move(edge: .top))
            }
            HStack(alignment: .firstTextBaseline) {
                MapTravelInfoView(
                    locationDescription: "Your Location",
                    locationSystemName: "mappin.circle",
                    travelInfos: userTravelInfos
                )
                Spacer()
                MapTravelInfoView(
                    locationDescription: "Friend Location",
                    locationSystemName: "person.crop.circle.dashed",
                    travelInfos: friendTravelInfos
                )
            }
            .padding()
            HStack {
                if let selectedResult {
                    ButtonHaptic {
                        selectedResult.openInMaps()
                    } label: {
                        Label {
                            Text("Open in Maps")
                                .font(.textBody)
                                .fontWeight(.semibold)
                                .foregroundStyle(.textPrimary)
                        } icon: {
                            Image(systemName: "map")
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .foregroundStyle(.tint)
                    .background(.primaryComponent)
                    .strokeRounded()
                    .onAppear {
                        settingsDetent = .medium
                    }
                }
            }
            Spacer()
            if shouldExpandInfos {
                ButtonHaptic {
                    searchResults.removeAll()
                    search(for: meetingRequest.selectedCategory)
                } label: {
                    Label {
                        Text("Search Here")
                    } icon: {
                        Image(systemName: "magnifyingglass.circle")
                    }
                }
                .buttonStyle(.CTAButton)
                .padding()
                .transition(.move(edge: .bottom))
            }
        }
        .onChange(of: selectedResult) {
            Task {
                if selectedResult != nil {
                    settingsDetent = Self.mediumDetent
                } else {
                    shouldExpandInfos = true
                }
            }
        }
        .onChange(of: settingsDetent) {
            HapticManager.shared.playHaptic(of: .sheetSlide)
            Task {
                /// Sleep for 1 seconds
                try? await Task.sleep(nanoseconds: 100_000_000)
                withAnimation {
                    if settingsDetent == Self.smallDetent && selectedResult != nil {
                        shouldExpandInfos = false
                    } else {
                        shouldExpandInfos = true
                    }
                }
            }
        }
        .background(.thinMaterial)
        .interactiveDismissDisabled()
        .presentationDragIndicator(.visible)
        .presentationDetents([Self.smallDetent, Self.mediumDetent, Self.largeDetent], selection: $settingsDetent)
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
        .presentationCornerRadius(Styles.Radius.radius2x2Quarter)
    }
}

struct MapAreaView: View {

    private let meetingRequest: MeetingRequest
    private let userImage = "mappin.circle"
    private let friendImage = "person.crop.circle.dashed"
    @State private var position: MapCameraPosition = .automatic
    @State private var searchResults: [MKMapItem] = []
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var selectedResult: MKMapItem?
    @State private var userTravelInfos: MapTravelInfos
    @State private var friendTravelInfos: MapTravelInfos
    @Environment(\.requestReview) private var requestReview
    @Environment(UserPreferences.self) private var preferences

    @MapContentBuilder private var mapAnnotationView: some MapContent {
        Annotation("User Location", coordinate: meetingRequest.userLocation.placemark.coordinate) {
            ZStack {
                Circle()
                    .foregroundStyle(.tintMain)
                Image(systemName: userImage)
                    .padding(5)
                    .foregroundStyle(.white)
            }
        }
        .annotationTitles(.hidden)
        Annotation("Friend Location", coordinate: meetingRequest.friendLocation.placemark.coordinate) {
            ZStack {
                Circle()
                    .foregroundStyle(.tintRed)
                Image(systemName: friendImage)
                    .padding(5)
                    .foregroundStyle(.white)
            }
        }
        .annotationTitles(.hidden)
        ForEach(searchResults, id: \.self) { result in
            Marker(item: result)
        }
        .annotationTitles(.hidden)
        if let userRoute = userTravelInfos.route {
            MapPolyline(userRoute)
                .stroke(.tintMain, lineWidth: 5)
        }
        if let friendRoute = friendTravelInfos.route {
            MapPolyline(friendRoute)
                .stroke(.tintRed, lineWidth: 5)
        }
    }

    init(meetingRequest: MeetingRequest) {
        self.meetingRequest = meetingRequest
        self.userTravelInfos = MapTravelInfos(location: meetingRequest.userLocation, transportType: meetingRequest.userTransportType)
        self.friendTravelInfos = MapTravelInfos(location: meetingRequest.friendLocation, transportType: meetingRequest.friendTransportType)
    }

    var body: some View {
        Map(position: $position, selection: $selectedResult) {
            mapAnnotationView
        }
        .mapStyle(.standard(elevation: .realistic))
        .sheet(isPresented: .constant(true)) {
            MapInfoSheet(
                meetingRequest: meetingRequest,
                selectedResult: selectedResult,
                userTravelInfos: userTravelInfos,
                friendTravelInfos: friendTravelInfos,
                searchResults: $searchResults,
                visibleRegion: visibleRegion
            )
        }
        .navigationTitle("\(meetingRequest.selectedCategory)")
        .onChange(of: searchResults) {
            position = .automatic
        }
        .onChange(of: selectedResult) {
            userTravelInfos.resetInfos()
            friendTravelInfos.resetInfos()
            userTravelInfos.updateRouteETA(with: selectedResult)
            friendTravelInfos.updateRouteETA(with: selectedResult)
        }
        .onMapCameraChange { context in
            visibleRegion = context.region
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        .onAppear {
            if AppStoreReviewManager.shared.shouldShowAppStoreReview() {
                AnalyticManager.shared.sendSignal(signalType: AnalyticEvent.didShowAppStoreReview)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    requestReview()
                }
                if !preferences.isPremium {
                    preferences.shouldBlockWithPaywall = true
                }
            }
        }
    }
}

#Preview {
    MapAreaView(meetingRequest: .preview)
        .environment(UserPreferences.shared)
}
