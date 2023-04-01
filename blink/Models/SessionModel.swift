//
//  SessionModel.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import Foundation

struct SessionModel: Codable {
    var id: String?
    var isAuthenticated: Bool = false
    var accessToken: String?
    var refreshToken: String?
    var firstName: String?
    var lastName: String?
}

extension SessionModel {
    init(session: SessionModel) {
        self.init(
            id: session.id,
            isAuthenticated: true,
            accessToken: session.accessToken,
            refreshToken: session.refreshToken
        )
    }
    
    mutating func clear() {
        self.id = nil
        self.isAuthenticated = false
        self.accessToken = nil
        self.refreshToken = nil
    }
}
