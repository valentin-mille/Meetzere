//
//  MapLookAroundView.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/21/24.
//

import SwiftUI
import MapKit

struct MapLookAroundView: View {
    @State private var lookAroundScene: MKLookAroundScene?
    let selectedResult: MKMapItem

    func getLookAroundScene() {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(mapItem: selectedResult)
            lookAroundScene = try? await request.scene
        }
    }

    var body: some View {
        LookAroundPreview(initialScene: lookAroundScene)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Text("\(selectedResult.name ?? "")")
                }
                .font(.caption)
                .foregroundStyle(.white)
                .padding(10)
            }
            .onAppear {
                getLookAroundScene()
            }
            .onChange (of: selectedResult) {
                getLookAroundScene()
            }
    }
}
