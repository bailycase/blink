//
//  ProfileView.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import SwiftUI

struct EditView: View {
    var body: some View {
        VStack {
            Text("edit me")
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.black)
    }
}

struct ProfileView: View {
    @State var show = false
    @ObservedObject var vm: ProfileViewModel
    
    init(vm: ProfileViewModel = .init()) {
        self.vm = vm
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
//                    Text(vm.userInitials)
//                        .font(.largeTitle)
                }
                .frame(width: 125, height: 125)
                .background(.ultraThinMaterial)
                .cornerRadius(.infinity)
                .padding(.top, 25)
                .padding(.bottom, 5)
                
                Text(vm.userName)
                    .font(.title2)
                
                Button(action: {
                    show = !show
                }) {
                    Text("Edit Profile")
                }
                .padding(.all, 10)
                .background(.ultraThinMaterial)
                .cornerRadius(.infinity)
                ForEach(vm.routes) { group in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: group.icon)
                            Text(group.title)
                        }
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.ultraThinMaterial)
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(group.routes) { route in
                                    Button(action: { vm.signOut() }){
                                        Image(systemName: route.icon)
                                            .padding(10)
                                            .background(.thickMaterial)
                                            .cornerRadius(.infinity)
                                        Text(route.title)
                                    }
                                    .padding(.horizontal, 10)
                                }
                                .padding(10)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.vertical, 10)
            }
        }
        .padding(.horizontal, 20)
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        let authManager = MockAuthManager()
//        let vm = ProfileViewModel(authManager: authManager)
//        ProfileView(vm: vm)
//            .frame(maxWidth: .infinity)
//            .background(Color.theme.background)
//    }
//}
