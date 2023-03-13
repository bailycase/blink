//
//  CapturedPhotoView.swift
//  blink
//
//  Created by Baily Case on 3/11/23.
//

import SwiftUI

struct CapturedPhotoView: View {
    let image: CGImage
    
    var body: some View {
        Image(image, scale: 1.0, orientation: .up, label: Text(""))
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

struct CapturedPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        let context = CGContext(data: nil, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipLast.rawValue).rawValue)!
        let image = context.makeImage()!
        CapturedPhotoView(image: image)
    }
}
