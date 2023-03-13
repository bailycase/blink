//
//  PhotoService.swift
//  blink
//
//  Created by Baily Case on 3/12/23.
//

import Foundation
import CoreImage
import UIKit

protocol PhotoServiceProtocol {
    func uploadPhoto(photo: CGImage)
}

class PhotoService: PhotoServiceProtocol {
    func uploadPhoto(photo: CGImage) {
        let fileName = "image"
        let url = URL(string: "http://192.168.1.139:8080/upload")
        
        let boundary = UUID().uuidString
        
        let session = URLSession.shared
        var request = URLRequest(url: url!)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        var data = Data()
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(fileName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        
        let img = UIImage(cgImage: photo)
        
        if let pngData = img.pngData() {
            data.append(pngData)
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        } else {
            // handle error if pngData is nil
        }
        
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: request, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            }
            
        }).resume()
        
    }
}
