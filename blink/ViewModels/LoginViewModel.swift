//
//  LoginViewModel.swift
//  blink
//
//  Created by Baily Case on 3/19/23.
//

import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    @Published var phoneNumber = "+15807611583"
    @Published var isLoading = false
    @Published var error: String?
    
    private let authService: AuthService
    private var subscriptions = Set<AnyCancellable>()
    
    init(authService: AuthService = .init()) {
        self.authService = authService
    }
    
    let didComplete = PassthroughSubject<String, Never>()
    
    public func login() {
        self.isLoading = true
        let request = LoginAction.Request(phoneNumber: phoneNumber)
        authService.loginWithPhoneNumber(request)
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    self.error = error.localizedDescription
                case .finished:
                    if self.error != nil {
                        self.error = nil
                    }
                }
            } receiveValue: { response in
                self.didComplete.send(response.phoneNumber)
            }.store(in: &subscriptions)
    }
}
