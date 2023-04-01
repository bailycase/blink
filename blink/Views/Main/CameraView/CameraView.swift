//
//  CameraView.swift
//  blink
//
//  Created by Baily Case on 3/15/23.
//

import SwiftUI

struct CameraView: View {
    let vm: CameraPreviewViewModel = CameraPreviewViewModel()
    
    var body: some View {
        VStack() {
            Button(action: {
                vm.sendTest()
            }) {
                Text("test session")
            }
            //            agoraVideoView.frame(maxWidth: .infinity, maxHeight: .infinity).background(.purple).ignoresSafeArea()
            //            HStack {
            //                Button("Start Video Call") {
            //                    Task {
            //                        await agoraVideoView.joinChannel()
            //                    }
            //                }.background(.green)
            //
            //                Button("Leave Video Call") {
            //                    Task {
            //                        await agoraVideoView.leaveChannel()
            //                    }
            //                }.background(.red)
            //            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.theme.background)
            .preferredColorScheme(.dark)
    }
}
