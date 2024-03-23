//
//  MeetingFormView.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/20/24.
//

import SwiftUI
import MapKit

enum LocationType: Hashable {

    case user
    case custom

    var description: String {
        switch self {
        case .user:
            return "Actual"
        case .custom:
            return "Custom"
        }
    }
}

@Observable
final class MeetingRequest: Observable, Identifiable, Hashable, Equatable {

    var id = UUID()
    var userLocation: MKMapItem
    var userTransportType: TransportType
    var selectedCategory: String
    var friendLocation: MKMapItem
    var friendTransportType: TransportType

    init(userLocation: MKMapItem, userTransportType: TransportType, selectedCategory: String, friendLocation: MKMapItem, friendTransportType: TransportType) {
        self.userLocation = userLocation
        self.userTransportType = userTransportType
        self.selectedCategory = selectedCategory
        self.friendLocation = friendLocation
        self.friendTransportType = friendTransportType
    }

    static func == (lhs: MeetingRequest, rhs: MeetingRequest) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(userLocation)
        hasher.combine(selectedCategory)
        hasher.combine(friendLocation)
    }

    static let preview = MeetingRequest(
        userLocation: .previewUserLocation(),
        userTransportType: .walking,
        selectedCategory: MKPointOfInterestCategory.restaurant.name,
        friendLocation: .previewFriendLocation(),
        friendTransportType: .publicTransport
    )
}

@MainActor
struct MeetingFormView: View {
    private let meetingCategories: [String] = ["restaurant", "bakery", "brewery"]
    @Environment(UserPreferences.self) private var preferences
    @State private var userLocation: MKMapItem? = MeetingRequest.preview.userLocation
    @State private var userTransportType: TransportType = .walking
    @State private var selectedCategory: String = MKPointOfInterestCategory.restaurant.name
    @State private var friendLocation: MKMapItem? = MeetingRequest.preview.friendLocation
    @State private var friendTransportType: TransportType = .walking
    @State private var router = RouterPath()

    private func isValidRequest() -> Bool {
        return userLocation != nil && friendLocation != nil
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Form {
                    Section {
                        ButtonHaptic(action: {
                            router.presentedSheet = .mapAddressSelection("Your Location", { selectedAddress in
                                userLocation = selectedAddress
                            })
                        }, label: {
                            Text(userLocation?.placemark.title ?? "Choose...")
                        })
                        Picker("Your Transport", selection: $userTransportType) {
                            ForEach(TransportType.allCases, id: \.self) { transportType in
                                Text(transportType.name)
                                    .font(.textBody)
                                    .foregroundStyle(.textPrimary)
                                    .tag(transportType.name)
                            }
                        }
                    } header: {
                        Text("Your Location")
                            .fontWeight(.semibold)
                    }
                    Section {
                        ButtonHaptic(action: {
                            router.presentedSheet = .mapAddressSelection("Friend Location", { selectedAddress in
                                friendLocation = selectedAddress
                            })
                        }, label: {
                            Text(friendLocation?.placemark.title ?? "Choose...")
                        })
                        Picker("Friend Transport", selection: $friendTransportType) {
                            ForEach(TransportType.allCases, id: \.self) { transportType in
                                Text(transportType.name)
                                    .font(.textBody)
                                    .foregroundStyle(.textPrimary)
                                    .tag(transportType.name)
                            }
                        }
                    } header: {
                        Text("Friend Location")
                            .fontWeight(.semibold)
                    }
                    Section {
                        Picker("Place", selection: $selectedCategory) {
                            ForEach(MKPointOfInterestCategory.supportedCategoryNames, id: \.self) { category in
                                Text(category)
                                    .font(.textBody)
                                    .foregroundStyle(.textPrimary)
                                    .tag(category)
                            }
                        }
                    } header: {
                        Text("Where to meet?")
                            .fontWeight(.semibold)
                    }
                }
                ButtonHaptic(action: {
                    guard let userLocation,
                          let friendLocation
                    else { return }
                    let request = MeetingRequest(
                        userLocation: userLocation,
                        userTransportType: userTransportType,
                        selectedCategory: selectedCategory,
                        friendLocation: friendLocation,
                        friendTransportType: friendTransportType
                    )
                    router.navigate(toDestination: .mapArea(request))
                },
                       label: {
                    Label {
                        Text("Search a place")
                    } icon: {
                        Image(systemName: "magnifyingglass.circle")
                    }
                })
                .buttonStyle(.CTAButton)
                .disabled(!isValidRequest())
                .padding()
            }
            .navigationTitle("Informations")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        HapticManager.shared.playHaptic(of: .tapGesture)
                        router.presentedSheet = .settings
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(preferences.theme.tint)
                    }
                }
            }
            .withAppRouter()
            .withSheetDestination(sheetDestination: $router.presentedSheet)
        }
    }
}

#Preview {
    MeetingFormView()
        .environment(UserPreferences.shared)
}
