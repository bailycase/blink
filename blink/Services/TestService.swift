//
//  TestService.swift
//  blink
//
//  Created by Baily Case on 3/26/23.
//

import Foundation
import Combine

enum TestServiceEndpoints {
    case test
    
    var requestTimeOut: Int {
        return 20
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .test:
            return .POST
        }
    }
    
    func createRequest() -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
//        headers["Authorization"] = "Bearer \(token)"
        return NetworkRequest(url: getURL(), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .test:
            return nil
        }
    }
    
    // compose urls for each request
    func getURL() -> String {
        return "http://192.168.1.139:8080/api/test/self"
    }
}

protocol TestServiceProtocol {
    func test() -> AnyPublisher<EmptyResponse, NetworkError>
}

public class TestService: TestServiceProtocol {
    private var networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func test() -> AnyPublisher<EmptyResponse, NetworkError> {
        let endpoint = TestServiceEndpoints.test
        let request = endpoint.createRequest()
        
        return self.networkService.request(request)
    }
}

struct EmptyResponse: Codable { }
