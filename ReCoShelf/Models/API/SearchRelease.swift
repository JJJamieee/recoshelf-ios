//
//  SearchRelease.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/11/14.
//

import SwiftUI

struct SearchResponse: Decodable {
    let results: [SearchResult]
}

struct SearchResult: Decodable {
    let type: String
    let id: Int
}
