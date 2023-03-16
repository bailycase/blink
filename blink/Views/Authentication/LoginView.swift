//
//  LoginView.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var navigation: AuthenticationNavigationViewModel
    
    var body: some View {
        VStack{
            Button(action: {
                Task {
                    await sessionManager.login(withPhoneNumber: "+15807611583") {
                        navigation.navigate(path: .Verify)
                    }
                }
            }) {
                Text("Login")
            }
        }.background(.blue)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
