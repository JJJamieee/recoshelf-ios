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
    @StateObject private var viewModel = MusicCollectionViewModel()
    @Environment(\.modelContext) private var context
    
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
                        if selectedReleases.isEmpty {
                            Button(action: {
                                isEditing = false
                                selectedReleases = []
                            }) {
                                Image(systemName: "xmark.circle")
                            }
                        } else {
                            Button(action: {
                                selectedReleases.forEach { context.delete($0) }
                                try? context.save()
                                
                                isEditing = false
                                selectedReleases = []
                            }) {
                                Image(systemName: "trash.circle")
                            }
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
                                id: release.sourceReleaseID,
                                title: release.title,
                                artist: release.artists.map(\.name).joined(separator: ", "),
                                releaseYear: release.releaseYear,
                                selectedReleaseIds: selectedReleases.map { $0.sourceReleaseID },
                                isEditing: $isEditing
                            )
                        }
                        .buttonStyle(.plain)
                    } else {
                        NavigationLink {
                            ReleaseDetailView(release: release)
                        } label: {
                            MusicCollectionItemView(
                                id: release.sourceReleaseID,
                                title: release.title,
                                artist: release.artists.map(\.name).joined(separator: ", "),
                                releaseYear: release.releaseYear,
                                selectedReleaseIds: selectedReleases.map { $0.sourceReleaseID },
                                isEditing: $isEditing
                            )
                        }
                    }
                }
                .listStyle(.plain)
            }
            .padding(20)
            .task { await viewModel.syncReleases(context: context) }
            .refreshable { await viewModel.syncReleases(context: context) }
            .overlay(alignment: .bottomTrailing) {
                if viewModel.isSyncing {
                    ProgressView()
                        .padding()
                }
            }
            
            if let errorMessage = viewModel.errorMessage {
                ToastView(message: errorMessage, style: .failed)
            }
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
