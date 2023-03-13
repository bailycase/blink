//
//  Login.swift
//  blink
//
//  Created by Baily Case on 3/9/23.
//

import SwiftUI
import AuthenticationServices
import Supabase

func handleRequest() {
    
}

func handleCompletion() {
    
}

struct Login: View {
    var body: some View {
        VStack {
            Text("Hello, I am the login!")
            SignInWithAppleButton(.continue, onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            }, onCompletion: { result in
                switch result {
                case .success(let authResult):
                    print("Auth succcessss")
                case .failure(let error):
                    print("Auth failed: " + error.localizedDescription)
                }
            }).frame(width: 280, height: 45)
        }
        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
