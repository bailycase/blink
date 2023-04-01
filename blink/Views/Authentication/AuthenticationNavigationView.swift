//
//  AuthenticationNavigationView.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import SwiftUI

struct AuthenticationNavigationView: View {
    @ObservedObject var vm = AuthenticationNavigationViewModel.shared
    
    var body: some View {
        ZStack {
            switch vm.onboardingState.currentStep {
            case .landing:
                LandingView(authVM: vm).transition(.move(edge: .leading))
            case .login:
                LoginView(vm: vm.makeLoginViewVM(), authNavigation: vm).transition(.move(edge: .leading))
            case.verify:
                VerifyView(vm: vm.makeVerifyViewVM()).tag(OnboardingState.Step.verify).transition(.move(edge: .leading))
            case.setupName:
                SetupName(vm: vm.makeSetupNameVM()).tag(OnboardingState.Step.setupName)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: vm.onboardingState.currentStep)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .environmentObject(vm)
    }
}

struct AuthenticationNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationNavigationView()
    }
}
