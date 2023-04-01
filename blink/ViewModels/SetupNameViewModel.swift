//
//  SetupNameViewModel.swift
//  blink
//
//  Created by Baily Case on 3/22/23.
//

import Foundation
import Combine

@MainActor
class SetupNameViewModel: ObservableObject {
    @Published var firstName = "Baily"
    @Published var lastName = "Case"
    @Published var isLoading = false
    @Published var error: String?
    
    private let userService: UserService
    private var subscriptions = Set<AnyCancellable>()
    
    init(userService: UserService = .init()) {
        self.userService = userService
    }
    
    let didComplete = PassthroughSubject<UserModel, Never>()
    
    public func setName() {
        self.isLoading = true
        let request = UpdateUserAction.Request(firstName: firstName, lastName: lastName)
        userService.updateUser(request)
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.error = error.localizedDescription
                case .finished:
                    if self.error != nil {
                        self.error = nil
                    }
                }
            } receiveValue: { response in
                self.didComplete.send(response)
            }.store(in: &subscriptions)
    }
}
