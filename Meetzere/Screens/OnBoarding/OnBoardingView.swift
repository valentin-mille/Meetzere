//
//  OnBoardingView.swift
//  Purrkit
//
//  Created by Valentin Mille on 3/15/24.
//

import SwiftUI
import Lottie
import Observation

private struct OnBoardingModel: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let lottieName: String?
    let isLottieLooping: Bool

    init(title: String, description: String, lottieName: String?, isLottieLooping: Bool) {
        self.title = title
        self.description = description
        self.lottieName = lottieName
        self.isLottieLooping = isLottieLooping
    }
}

@MainActor
struct OnBoardingView: View {
    private let models: [OnBoardingModel] = [
        OnBoardingModel(
            title: "Prepare Next Place Meeting",
            description: "Finding a place has never been so easy",
            lottieName: "map",
            isLottieLooping: true
        ),
        OnBoardingModel(
            title: "Travel Overview",
            description: "Get the route, estimated travel time for you and your friend",
            lottieName: "friends",
            isLottieLooping: true
        ),
        OnBoardingModel(
            title: "Privacy Friendly",
            description: "No data stored about your location, never.",
            lottieName: "privacy",
            isLottieLooping: false
        ),
        OnBoardingModel(
            title: "Start Now",
            description: "Find your next meeting place",
            lottieName: "checkmark",
            isLottieLooping: false
        )
    ]
    @Environment(UserPreferences.self) private var preferences
    @State private var pageIndex: Int = 0

    func isLastModel() -> Bool {
        return pageIndex + 1 < models.count
    }

    func showNext() {
        if isLastModel() {
            pageIndex += 1
        } else {
            preferences.isOnBoardingCompleted = true
        }
    }

    var body: some View {
        let model = models[pageIndex]
        VStack {
            VStack(spacing: 20) {
                Spacer()
                if let lottieName = model.lottieName {
                    if model.isLottieLooping {
                        LottieView {
                            try await DotLottieFile.named(lottieName)
                        }
                        .looping()
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .id(model.id)
                    } else {
                        LottieView {
                            try await DotLottieFile.named(lottieName)
                        }
                        .playing()
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .id(model.id)
                    }
                }
                Spacer()
                VStack {
                    Text(model.title)
                        .font(.textTitle)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .fontWeight(.bold)
                    Text(model.description)
                        .font(.textBody)
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                }
            }
            .padding()
            IndicatorView(count: models.count, currentIndex: $pageIndex)
                .padding(.bottom, 20)
            ButtonHaptic {
                withAnimation(.easeInOut) {
                    showNext()
                }
            } label: {
                Text(isLastModel() ? "Next" : "Start")
            }
            .buttonStyle(.CTAButton)
            .padding()
        }
        .background(.mainBackground)
    }
}

#Preview {
    OnBoardingView()
        .environment(UserPreferences.shared)
}
