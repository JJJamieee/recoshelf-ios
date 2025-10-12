//
//  Release.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/12.
//

import Foundation

struct Release: Identifiable {
    let id = UUID()
    
    var title: String
    var artist: String
    var releaseYear: String
}
