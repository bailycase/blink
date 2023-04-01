//
//  VerifyCodeViewModel.swift
//  blink
//
//  Created by Baily Case on 3/19/23.
//

import Foundation
import Combine

@MainActor
class VerifyCodeViewModel: ObservableObject {
    @Published var code = "123456"
    @Published var isLoading = false
    
    private let phoneNumber: String
    private let authService: AuthService
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(phone: String, authService: AuthService = .init()) {
        self.phoneNumber = phone
        self.authService = authService
    }
    
    let didComplete = PassthroughSubject<UserModel, Never>()
    
    public func verifyCode() {
        self.isLoading = true
        let request = VerifyAction.Request(phoneNumber: self.phoneNumber, code: self.code)
        authService.verifyOTPCode(request)
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("all done")
                }
            } receiveValue: { response in
                self.didComplete.send(response)
            }.store(in: &subscriptions)
    }
}
