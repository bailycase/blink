////
////  CameraPreviewUIView.swift
////  blink
////
////  Created by Baily Case on 3/19/23.
////
//
//import Foundation
//import SwiftUI
//import AVKit
//
//public struct CameraPreviewUIView: UIViewRepresentable {
//    @StateObject var camera: CameraPreviewViewModel
//    
//    init(vm: CameraPreviewViewModel) {
//        _camera = StateObject(wrappedValue: vm)
//    }
//    
//    public func makeUIView(context: Context) -> UIView {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 450))
//        camera.previewLayer.frame = view.frame
//        
//        view.layer.addSublayer(camera.previewLayer)
//        
//        return view
//    }
//    
//    
//    public func updateUIView(_ uiView: UIView, context: Context) {}
//}
