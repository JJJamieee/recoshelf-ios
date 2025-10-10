//
//  MusicCollectionView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/4.
//

import SwiftUI

struct MusicCollectionView: View {
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
                MusicCollectionItemView(title: "Album1", artist: "Artist1", releaseYear: "1999")
                
                MusicCollectionItemView(title: "Album2", artist: "Artist2", releaseYear: "2003")
            }
            .listStyle(.plain)
        }
        .padding(20)
    }
}

#Preview {
    MusicCollectionView()
}
