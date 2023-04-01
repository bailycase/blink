////
////  PhotoService.swift
////  blink
////
////  Created by Baily Case on 3/19/23.
////
//
//import Foundation
//import SupabaseStorage
//import Combine
//
//enum PhotoServiceErrors: Error {
//    case missingFileName
//    case missingUser
//}
//
//class PhotoService: ObservableObject {
//    private let supabaseClient = SupabaseClientManager.shared.supabaseClient
//    private let authManager = AuthManager.shared
//    private var storage: StorageFileApi
//    
//    init() {
//        self.storage = supabaseClient.storage.from(id: "user-photos")
//    }
//    
//    func uploadPhoto(_ photo: File) async throws -> Void {
//        guard let fileName = photo.fileName else {
//            throw PhotoServiceErrors.missingFileName
//        }
//        
//        guard let user = authManager.user else {
//            throw PhotoServiceErrors.missingUser
//        }
//        
//        do {
//            try await storage.upload(path: "\(user.id.uuidString)/\(fileName)", file: photo, fileOptions: nil)
//        } catch {
//            print("some error happened: \(error)")
//        }
//    }
//}
