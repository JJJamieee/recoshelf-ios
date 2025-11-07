//
//  Track.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/14.
//

import Foundation
import SwiftData

@Model
class Track: Identifiable {
    var id: Int
    var duration: String
    var title: String
    
    init(id: Int, duration: String, title: String) {
        self.id = id
        self.duration = duration
        self.title = title
    }
}
