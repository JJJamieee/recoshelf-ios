//
//  Artist.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/11/18.
//

import Foundation
import SwiftData

@Model
class Artist: Identifiable {
    var id: Int
    var name: String
    var imageURL: URL?
    
    init(id: Int, name: String, imageURL: URL? = nil) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
}
