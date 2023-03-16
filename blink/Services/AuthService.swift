//
//  AuthService.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import Foundation
import GoTrue

public class AuthService {
    private let supabaseClient = SupabaseClientManager.shared.supabaseClient

    init() {}
    
    func login(withPhoneNumber: String) async throws -> Void {
        do {
            try await supabaseClient.auth.signInWithOTP(phone: withPhoneNumber)
        } catch {
            print("failure to login: \(error)")
        }
    }
    
    func verify(withPhoneNumber: String, withCode: String) async throws -> Void {
        do {
            try await supabaseClient.auth.verifyOTP(phone: withPhoneNumber, token: withCode, type: .sms)
        } catch {
            print("failure to verify code: \(error)")
        }
    }
    
    func getSession() async throws -> Session {
        do {
            let session = try await supabaseClient.auth.session
            return session
        } catch {
            print("failure to get session: \(error)")
            throw error
        }
    }
    
    func logout() async throws -> Void {
        do {
            try await supabaseClient.auth.signOut()
        } catch {
            throw error
        }
    }
}
