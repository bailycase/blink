//
//  Text.swift
//  blink
//
//  Created by Baily Case on 3/19/23.
//

import Foundation
import SwiftUI

extension Text {
    init(initialsFromName firstName: String?, lastName: String?) {
        let initials = (firstName?.prefix(1) ?? "") + (lastName?.prefix(1) ?? "")
        self.init(initials)
    }
}
