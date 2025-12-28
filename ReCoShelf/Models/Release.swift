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
    var id: Int?
    var sourceReleaseID: Int
    var title: String
    var artists: [Artist]
    var releaseYear: String
    var country: String
    var genres: [String]
    var tracklist: [Track]
    var imageURL: URL?
    var fetchedAt: Date?
    
    init(id: Int? = nil, sourceReleaseID: Int, title: String, artists: [Artist], releaseYear: String, country: String, genres: [String], tracklist: [Track], imageURL: URL? = nil, fetchAt: Date? = nil) {
        self.id = id
        self.sourceReleaseID = sourceReleaseID
        self.title = title
        self.artists = artists
        self.releaseYear = releaseYear
        self.country = country
        self.genres = genres
        self.tracklist = tracklist
        self.imageURL = imageURL
        self.fetchedAt = fetchAt
    }
}
