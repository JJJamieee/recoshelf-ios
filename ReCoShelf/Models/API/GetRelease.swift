//
//  GetRelease.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/11/14.
//

import SwiftUI

struct ReleaseResponse: Decodable {
    let id: Int
    let title: String
    let country: String
    let genres: [String]
    let year: Int
    let tracklist: [TrackResponse]
    let images: [ResourceImage]
    let artists: [ArtistResponse]
    let thumb: String
    
    // TODO use thumb for imageURL for now, consider make imageURL to accept multiple resources
    func toReleaseModel() -> Release {
        return Release(id: self.id, title: self.title, artists: self.artists.map{ $0.toArtistModel() }, releaseYear: String(self.year), country: self.country, genres: self.genres, tracklist: self.tracklist.map{ $0.toTrackModel() }, imageURL: URL(string: self.thumb))
    }
}

struct TrackResponse: Decodable {
    let position: String
    let duration: String
    let title: String
    
    func toTrackModel() -> Track {
        return Track(position: self.position, duration: self.duration, title: self.title)
    }
}

struct ResourceImage: Decodable {
    let height: Int
    let width: Int
    let type: String
    let resource_url: String
}

struct ArtistResponse: Decodable {
    let id: Int
    let name: String
    
    func toArtistModel() -> Artist {
        return Artist(id: self.id, name: self.name)
    }
}
