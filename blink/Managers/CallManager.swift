//
//  CallManager.swift
//  blink
//
//  Created by Baily Case on 3/25/23.
//

import CallKit
import Foundation

final class CallManager: NSObject, CXProviderDelegate {
    let provider = CXProvider(configuration: CXProviderConfiguration())
    let callController = CXCallController()
    
    override init() {
        super.init()
        provider.setDelegate(self, queue: nil)
    }
    
    public func reportIncomingCall(id: UUID) {
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: "Blink")
        update.hasVideo = true
        
        provider.reportNewIncomingCall(with: id, update: update) { error in
            if let error = error {
                print(String(describing: error))
            } else {
                print("Call reported")
            }
        }
    }
    
    public func startCall(id: UUID) {
        
    }
    
    // MARK: - Delegate Functions
    
    func providerDidReset(_ provider: CXProvider) {
        
    }
}
