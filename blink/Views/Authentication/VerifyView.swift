//
//  VerifyView.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import SwiftUI

struct VerifyView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State var code = ""
    
    var body: some View {
        TextField("Code input", text: $code).onSubmit {
            Task {
                await sessionManager.verify(withCode: code)
            }
        }
    }
}

struct VerifyView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyView()
    }
}
