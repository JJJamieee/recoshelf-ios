//
//  MusicCollectionView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/4.
//

import SwiftUI

struct MusicCollectionView: View {
    @State private var releases: [Release] = [
        Release(title: "Album1", artists: ["Artist1"], releaseYear: "1999", country: "Japan", genres: ["POP"], tracklist: []),
        Release(title: "Album2", artists: ["Artist2", "Artist3"], releaseYear: "2003", country: "America", genres: ["JAZZ"], tracklist: []),
    ]
    
    var body: some View {
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
            
            List {
                ForEach(releases) { release in
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

#Preview {
    MusicCollectionView()
}
