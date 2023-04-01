//
//  Date.swift
//  blink
//
//  Created by Baily Case on 3/19/23.
//

import Foundation

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    func getTimestamp() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateformat.string(from: self)
    }
}
