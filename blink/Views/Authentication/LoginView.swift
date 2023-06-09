//
//  LoginView.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var authNavigation: AuthenticationNavigationViewModel
    @StateObject var vm: LoginViewModel
    @FocusState var autoFocus: Bool
    
    init(vm: LoginViewModel, authNavigation: AuthenticationNavigationViewModel) {
        _vm = StateObject(wrappedValue: vm)
        _authNavigation = StateObject(wrappedValue: authNavigation)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let error = vm.error {
                Text(error)
            }
            Button(action: {
                autoFocus = false
                authNavigation.goBack()
            }) {
                Image(systemName: "arrow.left").font(.title)
            }
            .frame(width: 50, height: 50)
            .background(.ultraThinMaterial)
            .clipShape(Circle())
            VStack(alignment: .center) {
                Spacer()
                Text("What's your number?").font(.title)
                TextField("", text: $vm.phoneNumber)
                    .padding(20)
                    .font(.body)
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .focused($autoFocus)
                    .onAppear {
                        self.autoFocus = true
                    }
                    .onDisappear {
                        self.autoFocus = false
                    }
                Spacer()
                Button(action: {
                    vm.login()
                }) {
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        Text("Login")
                    }
                }
                .disabled(vm.isLoading)
                .buttonStyle(PrimaryButton())
                .padding(.top, 100)
                .padding(.bottom, self.autoFocus ? 15 : 0)
            }
        }
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.background)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = LoginViewModel()
        let an = AuthenticationNavigationViewModel()
        
        LoginView(vm: vm, authNavigation: an)
    }
}
