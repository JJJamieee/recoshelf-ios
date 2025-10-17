//
//  MusicCollectionView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/4.
//

import SwiftUI

struct MusicCollectionView: View {
    @State private var releases: [Release] = [
        Release(title: "Album1", artists: ["Artist1"], releaseYear: "1999", country: "Japan", genres: ["POP"], tracklist: [Track(duration: "3:14", title: "Track1"), Track(duration: "4:05", title: "Track2")]),
        Release(title: "Album2", artists: ["Artist2", "Artist3"], releaseYear: "2003", country: "America", genres: ["JAZZ"], tracklist: [Track(duration: "3:14", title: "Track1"), Track(duration: "4:05", title: "Track2")]),
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("My Music Collection")
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "checkmark.circle")
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "plus.circle")
                    }
                }
                .font(.title)
                .buttonStyle(.plain)
                
                List(releases) { release in
                    NavigationLink {
                        ReleaseDetailView(release: release)
                    } label: {
                        MusicCollectionItemView(
                            title: release.title,
                            artist: release.artists.joined(separator: ", "),
                            releaseYear: release.releaseYear
                        )
                    }
                }
                .listStyle(.plain)
            }
            .padding(20)
        }
    }
}

#Preview {
    MusicCollectionView()
}
