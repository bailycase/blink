////
////  UserManager.swift
////  blink
////
////  Created by Baily Case on 3/16/23.
////
//
//import Foundation
//
//@MainActor
//public class UserManager: ObservableObject {
//    private let supabaseClient = SupabaseClientManager.shared.supabaseClient
//    private let sessionManager = SessionManager.shared
//
//    @Published public var user: UserModel?
//
//    public static let shared = UserManager()
//
//    init() {
//        Task(priority: .high) {
//            await fetchUserData()
//        }
//    }
//
//    public func fetchUserData() async {
//        guard let userId = sessionManager.session.id else {
//            print("no user id in session?")
//            return
//        }
//
//        do {
//            let user: UserModel = try await supabaseClient.database.from("users").select().eq(column: "id", value: userId).single().execute().value
//            self.user = user
//            print("user manager user: \(self.user?.id)")
//        } catch {
//            print("error while getting user: \(error)")
//        }
//    }
//}
