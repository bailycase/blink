//
//  SetupName.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import SwiftUI

struct SetupName: View {
    //    @EnvironmentObject var sessionManager: SessionManager
    //    @EnvironmentObject var navigation: AuthenticationNavigationViewModel
    @StateObject var vm: SetupNameViewModel
    @FocusState var autoFocus: Bool
    
    init(vm: SetupNameViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                Spacer()
                Text("Enter your name").font(.title)
                TextField("", text: $vm.firstName)
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
                TextField("", text: $vm.lastName)
                    .padding(20)
                    .font(.body)
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .focused($autoFocus)
                    .padding(.top, 10)
                Spacer()
                Button(action: {
                    vm.setName()
                }) {
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        Text("Set Name")
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

struct SetupName_Previews: PreviewProvider {
    static var previews: some View {
        SetupName(vm: SetupNameViewModel())
    }
}
