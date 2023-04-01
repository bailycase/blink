//
//  MainNavigation.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import SwiftUI

struct MainNavigation: View {
    @State private var tabIndex = 1
    
    var body: some View {
        VStack {
            TabView(selection: $tabIndex) {
                ProfileView().tag(0)
                CameraView().tag(1)
//                MessagesView().tag(2)
            }
            .edgesIgnoringSafeArea(.top)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .gesture(DragGesture(minimumDistance: 100, coordinateSpace: CoordinateSpace.local), including: GestureMask.all)
        }
    }
}

struct MainNavigation_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigation()
    }
}
