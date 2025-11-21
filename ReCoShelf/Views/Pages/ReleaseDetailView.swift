//
//  ReleaseDetailView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/14.
//

import SwiftUI
import SwiftData

struct ReleaseDetailView: View {
    let release: Release
    @Environment(\.modelContext) private var context
    @Query private var existedRelease: [Release]
    @State private var showAddSuccessToast = false
    @State private var showRemoveSuccessToast = false
    
    init(release: Release) {
        self.release = release
        let releaseId = release.id
        _existedRelease = Query(filter: #Predicate { $0.id == releaseId })
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: release.imageURL)
                .frame(width: 200, height: 200)
            
            if (existedRelease.isEmpty) {
                Button {
                    context.insert(release)
                    showAddSuccessToast = true
                } label: {
                    Label("Add to Collection", systemImage: "heart.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(.pink)
                        .clipShape(Capsule())
                }
            } else {
                Button {
                    context.delete(release)
                    showRemoveSuccessToast = true
                } label: {
                    Label("Remove from Collection", systemImage: "heart.slash.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(.gray)
                        .clipShape(Capsule())
                }
            }
            
            VStack(alignment: .leading) {
                Text(release.title)
                    .font(.title)
                    .padding(.vertical, 5)
                Text(release.artists.map(\.name).joined(separator: ", "))
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
        .toast(isPresented: $showAddSuccessToast, message: "Add Successfully!", style: .success)
        .toast(isPresented: $showRemoveSuccessToast, message: "Remove Successfully!", style: .success)
    }
}

#Preview {
    ReleaseDetailView(release: Release(id: 1, title: "Album1", artists: [Artist(id: 1, name: "artist1"), Artist(id: 2, name: "artist2")], releaseYear: "1999", country: "Japan", genres: ["POP"], tracklist: [Track(position: "1", duration: "3:14", title: "Track1"), Track(position: "2", duration: "4:05", title: "Track2")]))
}
