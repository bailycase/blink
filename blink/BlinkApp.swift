//
//  blinkApp.swift
//  blink
//
//  Created by Baily Case on 3/9/23.
//

import SwiftUI


@main
struct BlinkApp: App {
    @StateObject private var sessionManager = SessionManager()
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(sessionManager)
        }
    }
}
