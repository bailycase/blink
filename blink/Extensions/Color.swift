//
//  Color.swift
//  blink
//
//  Created by Baily Case on 3/13/23.
//

import Foundation
import SwiftUI


extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let primary = Color("PrimaryColor")
    let accent = Color("Accent")
    let background = Color("Background")
}
