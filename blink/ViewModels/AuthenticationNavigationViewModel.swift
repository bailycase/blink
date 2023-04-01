//
//  AuthenticationNavigationViewModel.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import Foundation
import SwiftUI
import Combine

struct OnboardingState {
    enum Step {
        case landing
        case login
        case verify
        case setupName
//        case allowContacts
    }
    
    var phoneNumber: String?
    var currentStep: Step = .landing
}

@MainActor
class AuthenticationNavigationViewModel: ObservableObject {
    public static var shared = AuthenticationNavigationViewModel()
    private let sessionManager = SessionManager.shared
    
    @Published var onboardingState = OnboardingState()
    
    var subscription = Set<AnyCancellable>()
    
    func makeLoginViewVM() -> LoginViewModel {
        let vm = LoginViewModel()
        vm.didComplete
            .sink(receiveValue: didCompleteLogin)
            .store(in: &subscription)
        return vm
    }
    
    func makeVerifyViewVM() -> VerifyCodeViewModel {
        let vm = VerifyCodeViewModel(phone: onboardingState.phoneNumber!)
        vm.didComplete
            .sink(receiveValue: didCompleteVerify)
            .store(in: &subscription)
        return vm
    }
    
    func makeSetupNameVM() -> SetupNameViewModel {
        let vm = SetupNameViewModel()
        vm.didComplete
            .sink(receiveValue: didCompleteSetupName)
            .store(in: &subscription)
        return vm
    }
    
    func didCompleteLogin(phoneNumber: String) {
        self.onboardingState.phoneNumber = phoneNumber
        onboardingState.currentStep = .verify
    }
    
    func didCompleteVerify(user: UserModel) {
        if(user.firstName == nil && user.lastName == nil) {
            onboardingState.currentStep = .setupName
            return
        }
        
        sessionManager.setSession(SessionModel(id: user.id, isAuthenticated: true, firstName: user.firstName, lastName: user.lastName))
    }
    
    func didCompleteSetupName(user: UserModel) {
        sessionManager.setSession(SessionModel(id: user.id, isAuthenticated: true, firstName: user.firstName, lastName: user.lastName))
    }
    
    public func goNext() {
        switch onboardingState.currentStep {
        case .landing:
            onboardingState.currentStep = .login
        case .login:
            onboardingState.currentStep = .verify
        case .verify:
            onboardingState.currentStep = .setupName
        case .setupName:
            print("all done!")
            // finalize login
            //            sessionManager.finalizeLogin()
//        case .allowContacts:
//            onboardingState.currentStep
        }
    }
    
    public func goBack() {
        switch onboardingState.currentStep {
        case .login:
            onboardingState.currentStep = .landing
        case .verify:
            onboardingState.currentStep = .login
        case .setupName:
            onboardingState.currentStep = .verify
        default:
            break
        }
    }
}
