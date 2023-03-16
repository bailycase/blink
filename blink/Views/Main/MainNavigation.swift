//
//  MainNavigation.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import SwiftUI

struct SwipeNavigationTabView<Content: View>: View {
    let content: Content
    let swipeUpView: AnyView
    
    @State private var selectedTab = 0
    
    init(@ViewBuilder content: () -> Content, swipeUpView: AnyView) {
        self.content = content()
        self.swipeUpView = swipeUpView
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            content
                .tabItem { EmptyView() }
                .tag(0)
            
            swipeUpView
                .tabItem { EmptyView() }
                .tag(1)
        }
        .accentColor(.clear)
        .gesture(DragGesture().onEnded { value in
            if value.translation.width > 0 {
                selectedTab = max(selectedTab - 1, 0)
            } else if value.translation.width < 0 {
                selectedTab = min(selectedTab + 1, 1)
            } else if value.translation.height < 0 {
                selectedTab = 1
            }
        })
    }
}

struct MainNavigation: View {
    @State private var tabIndex = 1
    
    var body: some View {
        VStack {
            TabView(selection: $tabIndex) {
                ProfileView().tag(0)
                CameraView().tag(1)
                MessagesView().tag(2)
            }
            .edgesIgnoringSafeArea(.top)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct MainNavigation_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigation()
    }
}
