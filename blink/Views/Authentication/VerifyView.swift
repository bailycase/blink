//
//  VerifyView.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import SwiftUI

struct VerifyView: View {
    @StateObject var vm: VerifyCodeViewModel
    @FocusState var autoFocus: Bool
    
    init(vm: VerifyCodeViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                Spacer()
                Text("Enter your code").font(.title)
                TextField("", text: $vm.code)
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
                    Task {
                        await vm.verifyCode()
                    }
                }) {
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        Text("Verify")
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

struct VerifyView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = VerifyCodeViewModel(phone: "+1234567890")
        VerifyView(vm: vm)
    }
}
