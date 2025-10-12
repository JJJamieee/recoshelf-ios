//
//  MusicCollectionView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/4.
//

import SwiftUI

struct MusicCollectionView: View {
    @State private var releases: [Release] = [
        Release(title: "Album1", artist: "Artist1", releaseYear: "1999"),
        Release(title: "Album2", artist: "Artist2", releaseYear: "2003"),
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
                        artist: release.artist,
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
