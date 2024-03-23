//
//  PremiumBannerView.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/23/24.
//

import Foundation
import SwiftUI

struct PremiumBannerView: View {
    var body: some View {
        HStack {
            Image(systemName: "map")
                .resizable()
                .scaledToFit()
                .frame(width: Styles.Height.small)
            VStack(alignment: .leading) {
                Text("Go Premium")
                    .font(.textTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.tint)
                Text("Lifetime access to reach friend")
                    .font(.textBody)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.tint)
            }
            Spacer()
        }
        .padding()
        .background(.tint.opacity(0.2))
        .strokeRounded(cornerRadius: Styles.Radius.radius2x2Quarter)
    }
}

#Preview {
    PremiumBannerView()
        .tint(.tintMain)
        .foregroundStyle(.tintMain)
        .frame(maxWidth: .infinity)
        .padding()
}

