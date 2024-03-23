//
//  SettingMenuRow.swift
//  GentleEat
//
//  Created by Valentin Mille on 3/2/24.
//

import Foundation
import SwiftUI

@MainActor
struct SettingMenuRow: View {

    typealias CallbackSwitchType = (Bool) -> Void

    private let title: String
    private let systemName: String
    private let description: String
    private var values: [String]
    @Binding private var selectedValue: String
    @Environment(\.colorScheme) var colorScheme

    public init(
        title: String,
        description: String,
        systemName: String,
        values: [String],
        selectedValue: Binding<String>
    ) {
        self.title = title
        self.description = description
        self.systemName = systemName
        self.values = values
        self._selectedValue = selectedValue
    }

    var body: some View {
        Menu {
            ForEach(values, id: \.self) { value in
                ButtonHaptic {
                    selectedValue = value
                } label: {
                   Text(value)
                }
            }
        } label: {
            HStack(spacing: 15) {
                ImageIconView(systemName: systemName)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                    Text(description)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.textSecondary)
                        .font(.system(size: 11, weight: .regular, design: .rounded))
                        .minimumScaleFactor(0.9)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                Text(selectedValue)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .lineLimit(1)
                    .fixedSize()
                    .frame(alignment: .trailing)
            }
            .foregroundStyle(colorScheme == .dark ? .white : .black)
            .frame(height: 45)
            .labelStyle(CenteredIconLabel())
        }
    }
}

#Preview {
    List {
        Section {
            SettingMenuRow(
                title: "Time before mouthful",
                description: "Generally between 20 and 30 seconds and gain health benefits and there is more",
                systemName: "fork.knife.circle.fill",
                values: ["1", "2", "3"],
                selectedValue: .constant("2")
            )
            SettingRow(
                title: "Contact Us",
                systemName: "envelope"
            )
            SettingRow(
                title: "Contact Us",
                systemName: "pencil"
            )
        }
    }
}
