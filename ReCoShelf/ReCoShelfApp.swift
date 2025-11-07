//
//  ReCoShelfApp.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/9/27.
//

import SwiftUI
import SwiftData

@main
struct ReCoShelfApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Release.self)
        }
    }
}
