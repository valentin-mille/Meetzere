//
//  SettingRow.swift
//  GentleEat
//
//  Created by Valentin Mille on 3/1/24.
//

import SwiftUI

public struct SettingRow: View {

    public let title: String
    public let systemName: String

    public init(title: String, systemName: String) {
        self.title = title
        self.systemName = systemName
    }

    public var body: some View {
        HStack(spacing: 15) {
            ImageIconView(systemName: systemName)
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Styles.Size.size1x)
        }
        .frame(height: 40)
    }
}

#Preview {
    List {
        SettingRow(
            title: "Roadmap",
            systemName: "road.lanes"
        )
    }
}
