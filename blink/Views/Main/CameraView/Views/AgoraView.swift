//
//  AgoraView.swift
//  blink
//
//  Created by Baily Case on 3/25/23.
//

import Foundation
import SwiftUI
import AgoraRtcKit


struct AgoraVideoView: UIViewRepresentable {
    var agoraEngine: AgoraRtcEngineKit
    let selfView = UIView()
    let remoteView = UIView()
    let videoCanvas = AgoraRtcVideoCanvas()
    let remoteCanvas = AgoraRtcVideoCanvas()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(agoraEngine: agoraEngine, remoteView: remoteView)
    }
    
    class Coordinator: NSObject, AgoraRtcEngineDelegate {
        var agoraEngine: AgoraRtcEngineKit
        var remoteView: UIView
        
        init(agoraEngine: AgoraRtcEngineKit, remoteView: UIView) {
            self.agoraEngine = agoraEngine
            self.remoteView = remoteView
            super.init()
        }
        
        // Callback called when a new host joins the channel
        func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
            let videoCanvas = AgoraRtcVideoCanvas()
            videoCanvas.uid = uid
            videoCanvas.renderMode = .hidden
            videoCanvas.view = remoteView
            agoraEngine.setupRemoteVideo(videoCanvas)
        }
    }
    
    init() {
        let config = AgoraRtcEngineConfig()
        config.appId = "736a2f25e18247cfb85f45025ac6a982"
        self.agoraEngine = AgoraRtcEngineKit.sharedEngine(with: config, delegate: nil)
    }
    
    func setupLocalVideo() {
        // Enable the video module
        agoraEngine.enableVideo()
        // Start the local video preview
        agoraEngine.startPreview()
        videoCanvas.uid = 0
        videoCanvas.renderMode = .hidden
        videoCanvas.view = selfView
        // Set the local video view
        agoraEngine.setupLocalVideo(videoCanvas)
    }
    
    func setupRemoteVideo(uid: UInt) {
        remoteCanvas.uid = uid
        remoteCanvas.renderMode = .hidden
        remoteCanvas.view = remoteView
        agoraEngine.setupRemoteVideo(remoteCanvas)
    }
    
    func makeUIView(context: Context) -> UIView {
        self.agoraEngine.delegate = context.coordinator
        return remoteView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update view if necessary
    }
    
    static func dismantleUIView(_ uiView: UIView, coordinator: ()) {
        // Clean up view when it is removed from the SwiftUI view hierarchy
    }
    
    func joinChannel() async {
        let option = AgoraRtcChannelMediaOptions()
        
        option.clientRoleType = .broadcaster
        setupLocalVideo()
        
        // For a video call scenario, set the channel profile as communication.
        option.channelProfile = .communication
        
        // Join the channel with a temp token. Pass in your token and channel name here
        let result = agoraEngine.joinChannel(
            byToken: nil, channelId: "test", uid: 0, mediaOptions: option,
            joinSuccess: { (channel, uid, elapsed) in
//                setupRemoteVideo(uid: uid)
            }
        )
        // Check if joining the channel was successful and set joined Bool accordingly
        if result == 0 {
            print("joined channel")
        }
    }
    
    func leaveChannel() async {
        agoraEngine.stopPreview()
        let result = agoraEngine.leaveChannel(nil)
        // Check if leaving the channel was successful and set joined Bool accordingly
        if result == 0 {
            print("left channel")
        }
    }
}

