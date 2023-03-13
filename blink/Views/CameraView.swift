//
//  CameraView.swift
//  blink
//
//  Created by Baily Case on 3/9/23.
//

import SwiftUI

struct CameraView: View {
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if viewModel.capturedPhoto != nil {
                    CameraPreview(frame: viewModel.capturedPhoto)
                } else {
                    CameraPreview(frame: viewModel.frame)
                }
            }
        }.frame(height: 450)
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CameraViewModel()
        CameraView(viewModel: viewModel)
    }
}
