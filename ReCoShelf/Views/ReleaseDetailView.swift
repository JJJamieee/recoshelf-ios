//
//  ReleaseDetailView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/14.
//

import SwiftUI

struct ReleaseDetailView: View {
    var body: some View {
        VStack {
            Button(action: {}) {
                Image(systemName: "arrow.left.circle")
            }
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            
            AsyncImage(url: URL(string: "https://example.com/icon.png"))
                .frame(width: 200, height: 200)
            
            VStack(alignment: .leading) {
                Text("Album1")
                    .font(.title)
                    .padding(.vertical, 5)
                Text("Artist1")
                Text("UK / 2012")
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            
            List {
                TrackItemView(title: "Track1", duration: "3:05")
                TrackItemView(title: "Track2", duration: "4:15")
            }
            .listStyle(.plain)
        }
        .padding()
        .buttonStyle(.plain)
    }
}

#Preview {
    ReleaseDetailView()
}
