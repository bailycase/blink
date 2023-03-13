//
//  CameraControlsView.swift
//  blink
//
//  Created by Baily Case on 3/10/23.
//

import SwiftUI

struct CameraControlsView: View {
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        HStack(spacing: 50) {
                Button(action: { viewModel.toggleFlash() }) {
                    Image(systemName: viewModel.flashEnabled ? "bolt.fill" : "bolt.slash")
                        .font(.system(size: 30))
                        .imageScale(.large)
                        .tint(viewModel.flashEnabled ? .yellow : .white)
                }
                Button(action: {
                    viewModel.capturePhoto()
                }) {
                    Circle()
                        .fill(viewModel.capturedPhoto == nil ? Color.white : Color.clear)
                        .frame(width: 70, height: 70)
                        .padding(.all, 3)
                        .overlay(
                            Circle()
                                .stroke(Color.accentColor, lineWidth: 3)
                        )
                }.disabled(viewModel.capturedPhoto != nil)
                Button(action: { viewModel.switchView() }) {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: 30))
                        .imageScale(.large)
                        .tint(.white)
                }
        }
    }
}

struct CameraControlsView_Previews: PreviewProvider {
    static var previews: some View {
        CameraControlsView(viewModel: CameraViewModel())
    }
}
