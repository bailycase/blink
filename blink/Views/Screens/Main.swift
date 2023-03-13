//
//  Main.swift
//  blink
//
//  Created by Baily Case on 3/9/23.
//

import SwiftUI

struct Main: View {
    @ObservedObject var cameraViewModel = CameraViewModel()
    @State private var showingCredits = true
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle").font(.system(size: 30)).foregroundColor(.white)
                Spacer()
                Button(action: { showingCredits.toggle() }) {
                    Text("Press me")
                }
                .sheet(isPresented: $showingCredits) {
                            Text("This app was brought to you by Hacking with Swift")
                                .presentationDetents([.medium, .large])
                        }
                Spacer()
                Image(systemName: "message").imageScale(.large).foregroundColor(.white)
            }.padding(.horizontal).padding(.bottom, 25)
            VStack {
                CameraView(viewModel: cameraViewModel).padding(.bottom, 40)
                if cameraViewModel.capturedPhoto != nil {
                    CapturedPhotoControls(viewModel: cameraViewModel)
                } else {
                    CameraControlsView(viewModel: cameraViewModel)
                }
            }
            Spacer()
        }.frame(maxHeight: .infinity).background(.black)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
