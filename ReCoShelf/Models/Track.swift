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
    var id: UUID
    var position: String
    var duration: String
    var title: String
    
    init(position: String, duration: String, title: String) {
        self.id = UUID()
        self.position = position
        self.duration = duration
        self.title = title
    }
}
