//
//  AuthenticationManager.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import Foundation
import Combine
import GoTrue

protocol SessionManagerProtocol {
    var session: SessionModel { get }
    
    func setSession(_ session: SessionModel)
    func signOut()
}

public class SessionManager: ObservableObject, SessionManagerProtocol {
    public static var shared = SessionManager()
    private let keychainManager = KeychainManager()
    
    @Published var session: SessionModel
    
    init() {
        var isAuthenticated = false
        
        // get a session from the keychain if exists
        let keychainSession: SessionModel? = keychainManager.get("blink-session")
        
        // restore the session
        if let session = keychainSession {
            self.session = session
            if let cookies = URLSession.shared.configuration.httpCookieStorage?.cookies {
                for cookie in cookies {
                    HTTPCookieStorage.shared.setCookie(cookie)
                    if cookie.name == "blink-access-token" {
                        isAuthenticated = true
                    }
                }
            }
        } else {
            self.session = SessionModel(isAuthenticated: isAuthenticated)
        }
        
    }
    
    // MARK: Public Methods
    
    // Sets the session in shared state, and writes the session to the keychain
    func setSession(_ session: SessionModel) {
        self.session = session
        keychainManager.set(session, forKey: "blink-session")
    }
    
    public func signOut() {
        keychainManager.delete("blink-session")
        self.session = SessionModel(isAuthenticated: false)
    }
}

