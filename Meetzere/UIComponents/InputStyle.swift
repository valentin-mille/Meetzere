//
//  InputStyle.swift
//  Bubly
//
//  Created by Valentin Mille on 3/7/24.
//

import SwiftUI

struct InputStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.textBody.weight(.semibold))
            .lineLimit(1)
            .padding()
            .background(.primaryComponent)
            .font(.textBody)
            .strokeRounded()
    }
}

extension TextFieldStyle where Self == InputStyle {
    static var inputStyle: InputStyle {
        InputStyle()
    }
}

#Preview {
    TextField("Note here...", text: .constant(""), axis: .vertical)
        .tint(.textSecondary)
        .textFieldStyle(.inputStyle)
}
