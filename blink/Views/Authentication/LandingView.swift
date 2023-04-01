//
//  LandingView.swift
//  blink
//
//  Created by Baily Case on 3/19/23.
//

import SwiftUI

struct LandingView: View {
    @StateObject var authVM: AuthenticationNavigationViewModel
    
    init(authVM: AuthenticationNavigationViewModel) {
        _authVM = StateObject(wrappedValue: authVM)
    }
    
    
    var body: some View {
        VStack {
            Text("Landing View :)")
            Button(action: { authVM.goNext() }) {
                Text("Get Started").foregroundColor(.blue)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.background)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        let authNavigation = AuthenticationNavigationViewModel()
        LandingView(authVM: authNavigation)
    }
}
