////
////  CameraPreviewViewModel.swift
////  blink
////
////  Created by Baily Case on 3/18/23.
////
//
import Foundation
import Combine

//import AVKit
//import CoreImage
//import SwiftUI
//import SupabaseStorage
//import BottomSheet
//

/*
 
 app access key: 641e4b8c0e077649845bdfda
 app secret: vjTQ5o2QW7y9Bye8nQdVG608b5YntkRJl3IKuFCRJ7oS1VgKTd68p6qY_1gI5zqWMiqKYq2p6-pDJyN2rpLqxkMRYFGReZz9jG3lTHDSQv3N4VA24MWalr0TNvAgMkqFArg7VMZPOQljt9prhUFNy3-F-LWYZk1t5GXmkOOPBYA=
 customer id: 641e4b8c0e077649845bdfd8
 app id: 641e4b8c0e077649845bdfd9
 */

class CameraPreviewViewModel: NSObject, ObservableObject {
    private var testService = TestService()
    private var subscriptions = Set<AnyCancellable>()
    
    public func sendTest() {
        testService.test().sink { (completion) in
            print(completion)
        } receiveValue: { (response) in
            print(response)
        }.store(in: &subscriptions)
    }
}
//    private var photoService = PhotoService()
//    
//    private var capturePosition: AVCaptureDevice.Position = .front
//    private var videoOutput = AVCaptureVideoDataOutput()
//    private let photoOutput = AVCapturePhotoOutput()
//    
//    private let context = CIContext()
//    private let sessionQueue = DispatchQueue(label: "sessionQueue")
//    
//    @Published var captureSession = AVCaptureSession()
//    @Published var previewLayer = AVCaptureVideoPreviewLayer()
//    @Published var permissionGranted = false
//    @Published var capturedImage: UIImage? {
//        didSet {
//            if capturedImage != nil {
//                withAnimation(.spring()) {
//                    shareSheetPosition = .absolute(175)
//                }
//            } else {
//                withAnimation(.spring()) {
//                    shareSheetPosition = .hidden
//                }
//            }
//        }
//    }
//    @Published var shareSheetPosition: BottomSheetPosition = .hidden
//    
//    override init() {
//        super.init()
//        checkPermissions()
//        sessionQueue.async { [unowned self] in
//            self.setupCaptureSession()
//            self.captureSession.startRunning()
//        }
//    }
//    
//    private func checkPermissions() {
//        switch AVCaptureDevice.authorizationStatus(for: .video) {
//        case .authorized:
//            permissionGranted = true
//        case .notDetermined:
//            requestPermission()
//        default:
//            permissionGranted = false
//        }
//    }
//    
//    private func requestPermission() {
//        AVCaptureDevice.requestAccess(for: .video) { [self] granted in
//            permissionGranted = granted
//        }
//    }
//    
//    private func setupCaptureSession() {
//        guard permissionGranted else {
//            print("No permission granted")
//            return
//        }
//        captureSession.beginConfiguration()
//        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
//            print("failed to get video device")
//            return
//        }
//        do {
//            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
//            if captureSession.canAddInput(videoDeviceInput) {
//                captureSession.addInput(videoDeviceInput)
//            }
//        } catch let error {
//            print("failed to get video input: \(error.localizedDescription)")
//            return
//        }
//        
//        captureSession.addOutput(photoOutput)
//        
//        photoOutput.connection(with: .video)?.videoOrientation = .portrait
//        photoOutput.connection(with: .video)?.isVideoMirrored = true
//        
//        captureSession.commitConfiguration()
//        previewLayer.session = captureSession
//        previewLayer.videoGravity = .resizeAspectFill
//    }
//    
//    public func clearCapturedImage() {
//        DispatchQueue.main.async { [weak self] in
//            self?.capturedImage = nil
//        }
//    }
//    
//    public func capturePhoto() {
//        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
//        photoOutput.capturePhoto(with: settings, delegate: self)
//    }
//    
//    public func uploadPhoto() async -> Void {
//        guard let photo = capturedImage?.jpegData(compressionQuality: 1.0) else {
//            print("No captured photo")
//            return
//        }
//        
//        let date = Date().getTimestamp()
//        
//        let photoFile = File(name: date, data: photo, fileName: "\(date).jpeg", contentType: "image/jpeg")
//        
//        do {
//            try await photoService.uploadPhoto(photoFile)
//            clearCapturedImage()
//        } catch {
//            print("error getting photos \(error)")
//        }
//    }
//}
//
//extension CameraPreviewViewModel: AVCapturePhotoCaptureDelegate {
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        if let error = error {
//            print("Error capturing photo: \(error.localizedDescription)")
//            return
//        }
//        if let imageData = photo.fileDataRepresentation(),
//           let image = UIImage(data: imageData) {
//            capturedImage = image
//        }
//    }
//}
//
