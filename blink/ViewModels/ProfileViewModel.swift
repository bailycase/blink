////
////  ProfileViewModel.swift
////  blink
////
////  Created by Baily Case on 3/16/23.
////
//
import Foundation
import SwiftUI

struct ProfileRoute: Hashable, Identifiable {
    let title: String
    let id = UUID()
    let icon = "trophy.fill"
}

struct ProfileRouteGroup: Identifiable {
    let title: String
    let routes: [ProfileRoute]
    let icon = "trophy.fill"
    let id = UUID()
}

class ProfileViewModel: ObservableObject {
    private let sessionManager: SessionManagerProtocol
    
    init(sessionManager: SessionManager = SessionManager.shared) {
        self.sessionManager = sessionManager
    }
    
    var userName: String {
        if sessionManager.session.firstName == nil || sessionManager.session.lastName == nil {
            return "??"
        }
        
        return "\(sessionManager.session.firstName!) \(sessionManager.session.lastName!)"
    }
    
    public let routes: [ProfileRouteGroup] = [
        ProfileRouteGroup(title: "General", routes: [
            ProfileRoute(title: "Change Number"),
            ProfileRoute(title: "Blocked")
        ]),
        ProfileRouteGroup(title: "Farewell Zone", routes: [
            ProfileRoute(title: "Delete Account"),
            ProfileRoute(title: "Sign Out")
        ])
    ]
    
    // MARK: Methods
    public func signOut() {
        sessionManager.signOut()
    }
}
