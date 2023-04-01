//
//  BlinkAppDelegate.swift
//  blink
//
//  Created by Baily Case on 3/26/23.
//

import Foundation
import SwiftUI
import PushKit
import CallKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, PKPushRegistryDelegate {
    var voipRegistry: PKPushRegistry?
    var callProvider: CXProvider?
    var callManager: CXProviderDelegate = CallManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Request authorization for remote notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting authorization: \(error.localizedDescription)")
            } else if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        voipRegistry = PKPushRegistry(queue: DispatchQueue.main)
        voipRegistry?.delegate = self
        voipRegistry?.desiredPushTypes = [.voIP]
        
        let config = CXProviderConfiguration()
        config.supportsVideo = true
        config.supportedHandleTypes = [.phoneNumber]
        config.maximumCallsPerCallGroup = 1
        
        // Create the provider and attach the custom delegate object
        // used by the app to respond to updates.
        callProvider = CXProvider(configuration: config)
        callProvider?.setDelegate(callManager, queue: nil)
        
        return true
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        if type == .voIP {
            if let handle = payload.dictionaryPayload["handle"] as? String,
               let uuidString = payload.dictionaryPayload["callUUID"] as? String,
               let callUUID = UUID(uuidString: uuidString) {
                
                // Configure the call information data structures.
                let callUpdate = CXCallUpdate()
                let phoneNumber = CXHandle(type: .phoneNumber, value: handle)
                callUpdate.remoteHandle = phoneNumber
                
                // Report the call to CallKit, and let it display the call UI.
                self.callProvider?.reportNewIncomingCall(with: callUUID, update: callUpdate, completion: { (error) in
                    if error == nil {
                        // If the system allows the call to proceed, make a data record for it.
                        //                        let newCall = VoipCall(callUUID, phoneNumber: phoneNumber)
                        //                        self.callManager.addCall(newCall)
                    }
                })
                
                // Asynchronously register with the telephony server and
                // process the call. Report updates to CallKit as needed.
                //                establishConnection(for: callUUID)
            }
        }
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        if type == .voIP {
            let voipToken = pushCredentials.token.map { String(format: "%02.2hhx", $0) }.joined()
            print("VoIP device token: \(voipToken)")
        }
    }
    
    // Handle registration for remote notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(token)")
    }
    
    // Handle failure to register for remote notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
}
