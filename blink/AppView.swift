//
//  AppView.swift
//  blink
//
//  Created by Baily Case on 3/9/23.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        RootNavigation()
    }
}

struct RootNavigation: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        if sessionManager.session.isAuthenticated {
            MainNavigation()
        } else {
            AuthenticationNavigationView()
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        let sessionManager = SessionManager()
        AppView()
            .environmentObject(sessionManager)
    }
}
