//
//  SettingPickerRow.swift
//  Purrkit
//
//  Created by Valentin Mille on 3/14/24.
//

import SwiftUI

struct SettingPickerRow: View {

    @Binding private var selection: String
    private let selectionOptions: [String]
    private let title: String
    private let systemName: String

    init(title: String, selection: Binding<String>, selectionOptions: [String], systemName: String) {
        self.title = title
        self._selection = selection
        self.selectionOptions = selectionOptions
        self.systemName = systemName
    }

    var body: some View {
        Picker(selection: $selection) {
            ForEach(selectionOptions, id: \.self) { option in
                Text(option)
            }
        } label: {
            HStack {
                ImageIconView(systemName: systemName)
                Text(title)
                    .font(.textBody)
                    .fontWeight(.semibold)
            }
        }
        .frame(height: 45)
    }
}

#Preview {
    Form {
        SettingPickerRow(
            title: "Mass Unit",
            selection: .constant(""),
            selectionOptions: Array(["Option 1", "Option 2"]),
            systemName: "scalemass"
        )
    }
}
