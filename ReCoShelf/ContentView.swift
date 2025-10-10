//
//  ContentView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/9/27.
//

import SwiftUI

struct ContentView: View {
    @State var isLoggedIn: Bool = false

    var body: some View {
        VStack {
            if isLoggedIn {
                MusicCollectionView()
            } else {
                WelcomeView(isLoggedIn: $isLoggedIn)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
