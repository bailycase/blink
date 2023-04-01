//
//  AuthService.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import Foundation
import Combine

// MARK: Actions
public struct LoginAction {
    struct Request: Encodable {
        let phoneNumber: String
    }
    
    struct Response: Codable {
        let phoneNumber: String
    }
}

public struct VerifyAction {
    struct Request: Encodable {
        let phoneNumber: String
        let code: String
    }
}

enum AuthServiceEndpoints {
    case loginWithPhoneNumber(request: LoginAction.Request)
    case verifyOTPCode(request: VerifyAction.Request)
    
    var httpMethod: HTTPMethod {
        switch self {
        case .loginWithPhoneNumber:
            return .POST
        case .verifyOTPCode:
            return .POST
        }
    }
    
    func createRequest() -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
//        headers["Authorization"] = "Bearer \(token)"
        return NetworkRequest(url: getURL(), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    var requestBody: Encodable? {
        switch self {
        case .loginWithPhoneNumber(let request):
            return request
        case .verifyOTPCode(let request):
            return request
        }
    }
    
    func getURL() -> String {
        switch self {
        case .loginWithPhoneNumber:
            return "http://192.168.1.139:8080/api/auth/login"
        case .verifyOTPCode:
            return "http://192.168.1.139:8080/api/auth/verify"
        }
    }
}


protocol AuthServiceable {
    func loginWithPhoneNumber(_ phoneNumberRequest: LoginAction.Request) -> AnyPublisher<LoginAction.Response, NetworkError>
    func verifyOTPCode(_ verifyRequest: VerifyAction.Request) -> AnyPublisher<UserModel, NetworkError>
}

public class AuthService: AuthServiceable {
    private var networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func loginWithPhoneNumber(_ phoneNumberRequest: LoginAction.Request) -> AnyPublisher<LoginAction.Response, NetworkError> {
        let endpoint = AuthServiceEndpoints.loginWithPhoneNumber(request: phoneNumberRequest)
        let request = endpoint.createRequest()
        
        return self.networkService.request(request)
    }
    
    func verifyOTPCode(_ verifyRequest: VerifyAction.Request) -> AnyPublisher<UserModel, NetworkError> {
        let endpoint = AuthServiceEndpoints.verifyOTPCode(request: verifyRequest)
        let request = endpoint.createRequest()
        
        return self.networkService.request(request)
    }
}
