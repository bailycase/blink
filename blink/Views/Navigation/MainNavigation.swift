//
//  MainNavigation.swift
//  blink
//
//  Created by Baily Case on 3/9/23.
//

import SwiftUI

struct MainNavigation: View {
    @State private var selectedTabIndex = 1
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTabIndex) {
                Profile().tag(0)
                Main().tag(1)
                Messages().tag(2)
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
