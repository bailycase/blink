//
//  VerifyViewModel.swift
//  blink
//
//  Created by Baily Case on 3/16/23.
//

import Foundation

extension VerifyView {
    @MainActor class VerifyViewModel: ObservableObject {
        var sessionManager: SessionManager = SessionManager()
        
        func verify() async {
//            let session = await sessionManager.getSession()
        }
    }
}
