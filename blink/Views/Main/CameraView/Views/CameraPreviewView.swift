////
////  CameraPreviewView.swift
////  blink
////
////  Created by Baily Case on 3/18/23.
////
//
//import SwiftUI
//
//struct CameraPreviewView: View {
//    @ObservedObject var vm: CameraPreviewViewModel
//    
//    init(vm: CameraPreviewViewModel = .init()) {
//        self.vm = vm
//    }
//    
//    var body: some View {
//        ZStack {
//            if let image = vm.capturedImage {
//                Image(uiImage: image).resizable().scaledToFill()
//            } else {
//                CameraPreviewUIView(vm: vm)
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: 450)
//        .background(.black)
//        .cornerRadius(50)
//    }
//}
//
//struct CameraPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraPreviewView()
//    }
//}
