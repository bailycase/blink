//
//  AuthenticationManager.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import Foundation
import Combine


@MainActor
public class SessionManager: ObservableObject {
    private let authService = AuthService()
    
    @Published var session: SessionModel {
        didSet {
            if let token = session.token {
                KeychainManager.shared.set(token, forKey: "userToken")
            }
        }
    }
    
    internal init() {
        self.session = SessionModel(token: "")
        
        if let token = KeychainManager.shared.get("userToken") {
            self.session.token = token
            self.session.isAuthenticated = true
        }
    }
    
    public func login(withPhoneNumber: String, completion: @escaping () -> Void) async {
        do {
            try await authService.login(withPhoneNumber: withPhoneNumber)
            self.session.phoneNumber = withPhoneNumber
            completion()
        } catch {
            // Handle login error
            print("error while logging in: \(error)")
        }
    }
    
    public func verify(withCode: String) async {
        guard let phoneNumber = self.session.phoneNumber else {
            print("Error: phoneNumber is not set.")
            return
        }
        
        do {
            try await authService.verify(withPhoneNumber: phoneNumber, withCode: withCode)
            let session = try await authService.getSession()
            
            self.session.isAuthenticated = true
            self.session.phoneNumber = session.user.phone
            self.session.token = session.accessToken
        } catch {
            print("error while verifying code: \(error)")
        }
    }
    
    public func logout() async {
        do {
            try await authService.logout()
            // clear the model
            self.session.clear()
            // clear out the keychain
            KeychainManager.shared.delete("userToken")
        } catch {
            print("error while logging out: \(error)")
        }
    }
}
