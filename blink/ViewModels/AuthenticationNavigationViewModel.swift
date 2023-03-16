//
//  AuthenticationNavigationViewModel.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import Foundation
import SwiftUI

enum Path: Hashable {
    case Login
    case Verify
}

class AuthenticationNavigationViewModel: ObservableObject {
    @Published var currentPath: [Path] = []
    
    func navigate(path: Path) {
        currentPath.append(path)
    }
}
