//
//  KeychainManager.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import Foundation
import KeychainSwift

class KeychainManager {
    let keychain = KeychainSwift()
    
    func set<T: Encodable>(_ value: T?, forKey key: String) {
        if let jsonData = try? JSONEncoder().encode(value) {
            keychain.set(jsonData, forKey: key)
        } else {
            print("Failed to encode value for key \(key)")
        }
    }
    
    func get<T: Decodable>(_ key: String) -> T? {
        if let jsonData = keychain.getData(key) {
            return try? JSONDecoder().decode(T.self, from: jsonData)
        } else {
            return nil
        }
    }
    
    func delete(_ key: String) {
        keychain.delete(key)
    }
}
