//
//  MusicCollectionItemView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/4.
//

import SwiftUI

struct MusicCollectionItemView: View {
    let id: Int
    let title: String
    let artist: String
    let releaseYear: String
    let selectedReleaseIds: [Int]
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            if isEditing {
                Button(action: {}) {
                    if selectedReleaseIds.contains(id) {
                        Image(systemName: "checkmark.square")
                    } else {
                        Image(systemName: "square")
                    }
                }
            }

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
        .contentShape(Rectangle())
    }
}

#Preview {
    MusicCollectionItemView(id: 1, title: "Title", artist: "Artist", releaseYear: "1999", selectedReleaseIds: [1, 2], isEditing: .constant(false))
}
