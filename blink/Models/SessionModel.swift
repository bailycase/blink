//
//  SessionModel.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import Foundation

struct SessionModel {
    var token: String?
    var phoneNumber: String?
    var firstName: String?
    var lastName: String?
    var isAuthenticated: Bool = false
}

extension SessionModel {
    init(session: SessionModel) {
        self.init(
            token: session.token,
            phoneNumber: session.phoneNumber,
            isAuthenticated: true
        )
    }
    
    mutating func clear() {
        self.isAuthenticated = false
        self.phoneNumber = nil
        self.token = nil
        self.firstName = nil
        self.lastName = nil
    }
}
