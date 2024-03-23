//
//  ContentView.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/19/24.
//

import SwiftUI
import SwiftData
import MapKit

/// Some ideas
/// - Gamified the experience by adding opacity elements that fills when entering informations (dopamine)

/// V0 workflow
/// - Enter user location
/// - Enter friend location
/// - Select points of interest (like restaurants, bakery, etc...)
/// - Show middle point of meeting and let user select the place
///     - Add insights when searching place. (e.g. pin for user location and friend, travel time for user and friend)
/// - Only one person per meet
/// - Open Maps when place defined
/// - Share location with the person

/// Plan for the core feature
/// MKCoordinateRegion -> use it to search in specific area (a region example is the one showed by the view camera maps)
///

/// V1
/// Add custom interest points
/// Import interest points from Apple Maps

// To Compute Area in Square Meter (from https://stackoverflow.com/a/40489608)
let kEarthRadius = 6378137.0

func radians(degrees: Double) -> Double {
    return degrees * .pi / 180
}

func regionArea(locations: [CLLocationCoordinate2D]) -> Double {

    guard locations.count > 2 else { return 0 }
    var area = 0.0

    for i in 0..<locations.count {
        let p1 = locations[i > 0 ? i - 1 : locations.count - 1]
        let p2 = locations[i]

        area += radians(degrees: p2.longitude - p1.longitude) * (2 + sin(radians(degrees: p1.latitude)) + sin(radians(degrees: p2.latitude)) )
    }
    area = -(area * kEarthRadius * kEarthRadius / 2)
    return max(area, -area) // In order not to worry about is polygon clockwise or counterclockwise defined.
}

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct MapContentView: View {
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    let mapFilters: MKPointOfInterestFilter = MKPointOfInterestFilter(including: [.restaurant, .bakery])
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )

    var body: some View {
        Map {
            ForEach(locations) { location in
//                Marker(location.name, image: "person.circle", coordinate: location.coordinate)
//                Marker(location.name, systemImage: "person.circle", coordinate: location.coordinate)
                Annotation(location.name, coordinate: location.coordinate) {
                    Text(location.name)
                        .font(.headline)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
                .annotationTitles(.hidden)
            }
        }
        .onAppear {
            MKMapView.appearance().pointOfInterestFilter = .some(mapFilters)
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    ButtonHaptic(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    MapContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
