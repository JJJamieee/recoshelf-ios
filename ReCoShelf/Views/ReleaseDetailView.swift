//
//  ReleaseDetailView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/14.
//

import SwiftUI

struct ReleaseDetailView: View {
    let release: Release
    
    var body: some View {
        VStack {
            AsyncImage(url: release.imageURL)
                .frame(width: 200, height: 200)
            
            VStack(alignment: .leading) {
                Text(release.title)
                    .font(.title)
                    .padding(.vertical, 5)
                Text(release.artists.joined(separator: ", "))
                Text("\(release.country) / \(release.releaseYear)")
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            
            List(release.tracklist) { track in
                TrackItemView(title: track.title, duration: track.duration)
            }
            .listStyle(.plain)
        }
        .padding()
        .buttonStyle(.plain)
    }
}

#Preview {
    ReleaseDetailView(release: Release(id: 1, title: "Album1", artists: ["Artist1"], releaseYear: "1999", country: "Japan", genres: ["POP"], tracklist: [Track(id: 1, duration: "3:14", title: "Track1"), Track(id: 2, duration: "4:05", title: "Track2")]))
}
