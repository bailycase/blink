//
//  ProfileView.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        Button(action: {
            Task {
                await sessionManager.logout()
            }
        }) {
            Text("Logout")
        }.background(.red)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
