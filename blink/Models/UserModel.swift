//
//  UserModel.swift
//  blink
//
//  Created by Baily Case on 3/16/23.
//

import Foundation

public final class UserModel: Codable {
    let id: String
    var phoneNumber: String
    var firstName: String?
    var lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "firstName"
        case lastName = "lastName"
        case phoneNumber = "phoneNumber"
    }
}
