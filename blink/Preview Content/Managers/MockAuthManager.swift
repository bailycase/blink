//
//  MockAuthManager.swift
//  blink
//
//  Created by Baily Case on 3/18/23.
//

import Foundation

//class MockAuthManager: AuthManagerProtocol, ObservableObject {
//    static let shared = AuthManager()
//    
//    @Published var session: SessionModel
//    @Published var user: UserModel?
//    
//    private let authService = AuthService()
//    private var userService: UserService
//    
//    init() {
//        self.session = SessionModel(id: UUID(), token: "some-token", isAuthenticated: true)
//        self.user = UserModel(id: UUID(), phoneNumber: "+1-123-456-7891", firstName: "John", lastName: "Doe")
//        self.userService = UserService(authService: self.authService)
//    }
//    
//    func signOut() async {
//        self.session = SessionModel(isAuthenticated: false)
//        self.user = nil
//    }
//}
