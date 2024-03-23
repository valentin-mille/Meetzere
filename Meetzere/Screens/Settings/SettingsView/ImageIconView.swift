//
//  ImageIconView.swift
//  GentleEat
//
//  Created by Valentin Mille on 3/2/24.
//

import Foundation
import SwiftUI

struct ImageIconView: View {

    private let systemName: String

    init(systemName: String) {
        self.systemName = systemName
    }

    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .foregroundColor(.tintMain)
    }
}
