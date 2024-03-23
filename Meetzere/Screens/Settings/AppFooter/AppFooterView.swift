//
//  AppFooterView.swift
//
//
//  Created by Valentin Mille on 2/23/24.
//

import Foundation
import SwiftUI

struct AppFooterView: View {
    let viewModel = AppFooterViewModel()

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center) {
                Text(viewModel.getAppName())
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.textSecondary)
                Text(viewModel.getAppVersion())
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.textSecondary)
            }
            Spacer()
        }
    }
}
