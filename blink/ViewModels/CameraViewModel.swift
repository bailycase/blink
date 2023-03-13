//
//  CameraViewModel.swift
//  blink
//
//  Created by Baily Case on 3/9/23.
//

import Foundation
import AVFoundation
import CoreImage
import SwiftUI


class CameraViewModel: NSObject, ObservableObject {
    private var model: CameraModel
    private var service: PhotoService
    
    @Published var frame: CGImage?
    @Published var flashEnabled = false
    @Published var captureDevice: AVCaptureDevice.Position = .front
    
    private var permissionGranted = false
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private let context = CIContext()
    private var videoOutput = AVCaptureVideoDataOutput()
    
    
    override init() {
        self.model = CameraModel()
        self.service = PhotoService()
        super.init()
        checkPermission()
        sessionQueue.async { [unowned self] in
            self.setupCaptureSession()
            self.captureSession.startRunning()
        }
    }
    
    var capturedPhoto: CGImage? {
        return model.capturedPhoto
    }
    
    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            permissionGranted = true
            
        case .notDetermined: // The user has not yet been asked for camera access.
            requestPermission()
            
            // Combine the two other cases into the default case
        default:
            permissionGranted = false
        }
    }
    
    func requestPermission() {
        // Strong reference not a problem here but might become one in the future.
        AVCaptureDevice.requestAccess(for: .video) { [unowned self] granted in
            self.permissionGranted = granted
        }
    }
    
    func getCamera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .unspecified)
        return discoverySession.devices.first(where: { $0.position == position })
    }
    
    func toggleFlash() {
        let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput
        
        if currentInput?.device.position == .front {
            flashEnabled = !flashEnabled
            if flashEnabled {
                UIScreen.main.brightness = 1.0 // set brightness to maximum
            } else {
                UIScreen.main.brightness = UIScreen.main.nativeBounds.maxY // set brightness to default
            }
            return
        }
        
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            try device.lockForConfiguration()
            
            if device.torchMode == .on {
                flashEnabled = false
                device.torchMode = .off
            } else {
                try device.setTorchModeOn(level: 1.0)
                flashEnabled = true
            }
            
            device.unlockForConfiguration()
        } catch {
            print("Error while setting up device configuration: \(error.localizedDescription)")
        }
    }
    
    func switchView() {
        captureSession.outputs.forEach { output in
            captureSession.removeOutput(output)
        }
        
        captureSession.beginConfiguration()
        guard let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput else {
            captureSession.commitConfiguration()
            return
        }
        
        let newPosition: AVCaptureDevice.Position = (captureDevice == .back) ? .front : .back
        captureDevice = newPosition
        guard let newCameraDevice = getCamera(with: newPosition) else {
            captureSession.commitConfiguration()
            return
        }
        
        guard let newVideoInput = try? AVCaptureDeviceInput(device: newCameraDevice) else {
            captureSession.commitConfiguration()
            return
        }
        
        captureSession.removeInput(currentInput)
        captureSession.addInput(newVideoInput)
        captureSession.addOutput(videoOutput)
        
        let videoConnection = videoOutput.connection(with: .video)
        videoConnection?.videoOrientation = .portrait
        videoConnection?.isVideoMirrored = newPosition == .front
        
        captureSession.commitConfiguration()
    }
    
    func setupCaptureSession() {
        guard permissionGranted else { return }
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
        guard captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
        captureSession.addOutput(videoOutput)
        
        videoOutput.connection(with: .video)?.videoOrientation = .portrait
        videoOutput.connection(with: .video)?.isVideoMirrored = true
    }
    
    func capturePhoto() {
        guard let image = frame else {
            return
        }
        
        model.addPhoto(image)
    }
    
    func clearPhoto() {
        model.clearPhoto()
    }
    
    func uploadPhoto() {
        guard let image = capturedPhoto else {
            return
        }
        
        service.uploadPhoto(photo: image)
    }
}

extension CameraViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let cgImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
        
        // All UI updates should be/ must be performed on the main queue.
        DispatchQueue.main.async { [unowned self] in
            self.frame = cgImage
        }
    }
    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CGImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        
        return cgImage
    }
}
