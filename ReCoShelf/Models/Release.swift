//
//  Release.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/12.
//

import Foundation
import SwiftData

@Model
class Release: Identifiable {
    var id: Int
    var title: String
    var artists: [String]
    var releaseYear: String
    var country: String
    var genres: [String]
    var tracklist: [Track]
    var imageURL: URL?
    
    init(id: Int, title: String, artists: [String], releaseYear: String, country: String, genres: [String], tracklist: [Track], imageURL: URL? = nil) {
        self.id = id
        self.title = title
        self.artists = artists
        self.releaseYear = releaseYear
        self.country = country
        self.genres = genres
        self.tracklist = tracklist
        self.imageURL = imageURL
    }
}
