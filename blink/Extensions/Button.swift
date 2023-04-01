//
//  Button.swift
//  blink
//
//  Created by Baily Case on 3/19/23.
//

import Foundation
import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(15)
            .background(Color.theme.primary)
            .clipShape(Capsule())
    }
}
