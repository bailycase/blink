//
//  blinkApp.swift
//  blink
//
//  Created by Baily Case on 3/9/23.
//

import SwiftUI


@main
struct BlinkApp: App {
    // Register the App Delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.theme.primary
                AppView()
                    .preferredColorScheme(.dark)
                    .background(Color.theme.background)
            }
        }
    }
}
