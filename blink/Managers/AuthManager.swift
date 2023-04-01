//
//  AuthManager.swift
//  blink
//
//  Created by Baily Case on 3/17/23.
//

//import Foundation
//
//protocol AuthManagerProtocol {
//    var session: SessionModel { get }
//    var user: UserModel? { get }
//    
//    func signOut() async -> Void
//}
//
//public class AuthManager: AuthManagerProtocol, ObservableObject {
//    static let shared = AuthManager()
//    
//    @Published var session: SessionModel
//    @Published var user: UserModel?
//    
//    private let authService = AuthService()
//    private var userService: UserService
//    
//    init() {
//        self.userService = UserService(authService: self.authService)
////        Task {
////            do {
////                let session = try await authService.getSession()
////                self.session = SessionModel(id: session.user.id, token: session.accessToken, isAuthenticated: true)
////
////                self.user = try await userService.getUserData()
////
////            } catch {
////                self.session = SessionModel(isAuthenticated: false)
////                print("Error fetching user data: \(error)")
////            }
////        }
//        self.session = SessionModel(isAuthenticated: false)
//    }
//    
//    public func login(_ phoneNumber: String) async -> Void {
//        do {
//            try await authService.login(withPhoneNumber: phoneNumber)
//        } catch {
//            print("error while logging in with phone number")
//        }
//    }
//    
//    public func verify(withPhoneNumber: String, token: String) async -> Void {
//        do {
//            try await authService.verify(withPhoneNumber: withPhoneNumber, withCode: token)
//        } catch {
//            print("error while logging in")
//        }
//    }
//    
//    public func finalizeLogin() -> Void {
//        self.session.isAuthenticated = true
//    }
//    
//    public func signOut() async -> Void {
//        do {
//            try await authService.logout()
//        } catch {
//            print("error while trying to log out")
//        }
//        
//        clearSession()
//    }
//    
//    private func clearSession() {
//        self.session = SessionModel(isAuthenticated: false)
//        self.user = nil
//    }
//}
