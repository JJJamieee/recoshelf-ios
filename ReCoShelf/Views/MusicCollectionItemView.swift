//
//  MusicCollectionItemView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/4.
//

import SwiftUI

struct MusicCollectionItemView: View {
    let title: String
    let artist: String
    let releaseYear: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                
                Text(artist)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(releaseYear)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    MusicCollectionItemView(title: "Title", artist: "Artist", releaseYear: "1999")
}
