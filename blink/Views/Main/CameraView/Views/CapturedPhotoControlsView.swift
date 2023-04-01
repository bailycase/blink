////
////  CapturedPhotoControlsView.swift
////  blink
////
////  Created by Baily Case on 3/19/23.
////
//
//import SwiftUI
//
//struct CapturedPhotoControlsView: View {
//    let vm: CameraPreviewViewModel
//    
//    init(vm: CameraPreviewViewModel = .init()) {
//        self.vm = vm
//    }
//    
//    var body: some View {
//        HStack(alignment: .center) {
//            Button(action: { vm.clearCapturedImage() }) {
//                Image(systemName: "xmark")
//                    .font(.system(.largeTitle))
//            }
//            Spacer()
//            Button(action: {
//                Task {
//                    await vm.uploadPhoto()
//                }
//            }) {
//                ZStack {
//                    Image(systemName: "paperplane.fill")
//                        .font(.system(.largeTitle))
//                }
//                .frame(width: 75, height: 75)
//                .background(.ultraThinMaterial)
//                .cornerRadius(.infinity)
//            }
//            Spacer()
//            Image(systemName: "square.and.arrow.down")
//                .font(.system(.largeTitle))
//            
//        }.padding(.horizontal, 75)
//    }
//}
//
//struct CapturedPhotoControlsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CapturedPhotoControlsView()
//    }
//}
