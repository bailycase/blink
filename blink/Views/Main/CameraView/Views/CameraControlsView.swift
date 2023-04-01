////
////  CameraControlsView.swift
////  blink
////
////  Created by Baily Case on 3/18/23.
////
//
//import SwiftUI
//
//struct CameraControlsView: View {
//    @StateObject var vm: CameraPreviewViewModel
//    
//    init(vm: CameraPreviewViewModel = .init()) {
//        _vm = StateObject(wrappedValue: vm)
//    }
//    
//    var body: some View {
//        HStack(alignment: .center) {
//            Image(systemName: "bolt.slash")
//                .font(.system(.largeTitle))
//            Spacer()
//            Button(action: {
//                vm.capturePhoto()
//            }) {
//                ZStack {}
//                    .frame(width: 75, height: 75)
//                    .background(.white)
//                    .cornerRadius(.infinity)
//            }
//            Spacer()
//            Image(systemName: "arrow.triangle.2.circlepath")
//                .font(.system(.largeTitle))
//            
//        }.padding(.horizontal, 75)
//    }
//}
//
//struct CameraControlsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraControlsView()
//    }
//}
