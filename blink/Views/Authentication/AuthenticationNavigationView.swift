//
//  AuthenticationNavigationView.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import SwiftUI

struct AuthenticationNavigationView: View {
    @StateObject var vm: AuthenticationNavigationViewModel
    
    init(vm: AuthenticationNavigationViewModel = .init()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack(path: $vm.currentPath ) {
            VStack {
                Text("Landing View :)")
                Button(action: { vm.navigate(path: .Login) }) {
                    Text("Get Started").foregroundColor(.blue)
                }
            }
            .navigationDestination(for: Path.self) { path in
                switch path {
                case .Login:
                    LoginView()
                case .Verify:
                    VerifyView()
                }
                
            }
        }.environmentObject(vm)
    }
}

struct AuthenticationNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationNavigationView()
    }
}
