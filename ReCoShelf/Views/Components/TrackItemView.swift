//
//  TrackItemView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/16.
//

import SwiftUI

struct TrackItemView: View {
    let title: String
    let duration: String
    
    var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            Text(duration)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    TrackItemView(title: "Track1", duration: "3:05")
}
