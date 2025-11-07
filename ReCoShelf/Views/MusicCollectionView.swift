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
    @State private var isEditing = false
    @State private var selectedReleases = Set<Release>()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("My Music Collection")
                    
                    Spacer()
                    
                    if !isEditing {
                        Button(action: {
                            isEditing = true
                        }) {
                            Image(systemName: "checkmark.circle")
                        }
                    } else {
                        Button(action: {
                            isEditing = false
                            selectedReleases = []
                        }) {
                            Image(systemName: "xmark.circle")
                        }
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
                    if isEditing {
                        Button {
                            toggleSelection(release)
                        } label: {
                            MusicCollectionItemView(
                                id: release.id,
                                title: release.title,
                                artist: release.artists.joined(separator: ", "),
                                releaseYear: release.releaseYear,
                                selectedReleaseIds: selectedReleases.map { $0.id },
                                isEditing: $isEditing
                            )
                        }
                        .buttonStyle(.plain)
                    } else {
                        NavigationLink {
                            ReleaseDetailView(release: release)
                        } label: {
                            MusicCollectionItemView(
                                id: release.id,
                                title: release.title,
                                artist: release.artists.joined(separator: ", "),
                                releaseYear: release.releaseYear,
                                selectedReleaseIds: selectedReleases.map { $0.id },
                                isEditing: $isEditing
                            )
                        }
                    }
                }
                .listStyle(.plain)
            }
            .padding(20)
        }
    }
    
    private func toggleSelection(_ release: Release) {
        if selectedReleases.contains(release) {
            selectedReleases.remove(release)
        } else {
            selectedReleases.insert(release)
        }
    }
}

#Preview {
    MusicCollectionView()
        .modelContainer(for: Release.self, inMemory: true)
}
