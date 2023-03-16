//
//  KeychainManager.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import Foundation
import KeychainSwift

class KeychainManager {
    static let shared = KeychainManager()
    
    let keychain = KeychainSwift()
    
    func set(_ value: String, forKey key: String) {
        keychain.set(value, forKey: key)
    }
    
    func get(_ key: String) -> String? {
        keychain.get(key)
    }
    
    func delete(_ key: String) {
        keychain.delete(key)
    }
}
