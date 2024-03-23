//
//  SettingSwitchRow.swift
//  GentleEat
//
//  Created by Valentin Mille on 3/2/24.
//

import Foundation
import SwiftUI

struct CenteredIconLabel: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {    // << here !!
            configuration.icon
            configuration.title
        }
    }
}

struct SettingSwitchRow: View {

    typealias CallbackSwitchType = (Bool) -> Void

    private let title: String
    private let systemName: String
    @Binding private var isOn: Bool
    @Environment(UserPreferences.self) private var preferences

    public init(
        title: String,
        systemName: String,
        isOn: Binding<Bool>
    ) {
        self.title = title
        self.systemName = systemName
        self._isOn = isOn
    }

    var body: some View {
        HStack(spacing: 15) {
            ImageIconView(systemName: systemName)
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: preferences.theme.tint))
        }
        .frame(height: 45)
        .labelStyle(CenteredIconLabel())
    }
}

#Preview {
    List {
        SettingSwitchRow(
            title: "Time before mouthful",
            systemName: "fork.knife.circle.fill",
            isOn: .constant(
                false
            )
        )
    }
//    .padding()
}
