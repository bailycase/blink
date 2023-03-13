//
//  CapturedPhotoControls.swift
//  blink
//
//  Created by Baily Case on 3/11/23.
//

import SwiftUI

struct CapturedPhotoControls: View {
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        HStack(spacing: 170) {
            Button(action: { viewModel.clearPhoto() }) {
                Image(systemName: "multiply").font(.system(size: 30)).tint(.white)
            }
            Button(action: { viewModel.uploadPhoto() }) {
                Image(systemName: "checkmark").font(.system(size: 30)).tint(.white)
            }
        }
    }
}

struct CapturedPhotoControls_Previews: PreviewProvider {
    static var previews: some View {
        CapturedPhotoControls(viewModel: CameraViewModel())
    }
}
