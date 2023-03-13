//
//  CameraPreview.swift
//  blink
//
//  Created by Baily Case on 3/11/23.
//

import SwiftUI

struct CameraPreview: View {
    let frame: CGImage?
    
    var body: some View {
        ZStack {
            if let image = frame {
                Image(image, scale: 1.0, orientation: .up, label: Text("")).resizable().aspectRatio(contentMode: .fill)
            } else {
                Color.gray.blur(radius: 100)
            }
        }.frame(height: 450).clipShape(RoundedRectangle(cornerRadius: 50))
    }
}

struct CameraPreview_Previews: PreviewProvider {
    static var previews: some View {
        let image = UIImage(named: "preview_image")
        CameraPreview(frame: image?.cgImage)
    }
}
