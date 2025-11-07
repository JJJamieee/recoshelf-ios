//
//  MusicCollectionView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/4.
//

import SwiftUI
import SwiftData

struct MusicCollectionView: View {
    @Query private var releases: [Release]
    @State private var showAddReleasePage = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("My Music Collection")
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "checkmark.circle")
                    }
                    
                    Button(action: {
                        showAddReleasePage = true
                    }) {
                        Image(systemName: "plus.circle")
                    }
                }
                .font(.title)
                .buttonStyle(.plain)
                .navigationDestination(isPresented: $showAddReleasePage) {
                    ScanReleaseBarcodeView()
                }
                
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
        .modelContainer(for: Release.self, inMemory: true)
}
