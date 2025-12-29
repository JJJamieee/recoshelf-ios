//
//  MusicCollectionViewModel.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/12/28.
//

import Foundation
import SwiftData

/// A view model that keeps `MusicCollectionView` on the main actor so UI state mutations are always thread-safe
@MainActor
final class MusicCollectionViewModel: ObservableObject {
    /// Published properties notify SwiftUI to redraw when they change.
    @Published var isSyncing = false
    @Published var errorMessage: String?

    /// Factory for creating the API client. This indirection makes the type
    /// easy to test—callers can inject a mock implementation—so the default
    /// remains lightweight for production.
    private let apiFactory: () throws -> UserReleaseAPI

    init(apiFactory: @escaping () throws -> UserReleaseAPI = { try UserReleaseAPI() }) {
        self.apiFactory = apiFactory
    }

    func syncReleases(context: ModelContext) async {
        guard !isSyncing else { return }

        isSyncing = true
        defer { isSyncing = false }

        do {
            let api = try apiFactory()
            let releases = try await api.fetchUserReleases()
            try replaceReleases(with: releases, context: context)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteReleases(_ releases: [Release], context: ModelContext) async {
        guard !isSyncing else { return }
        guard !releases.isEmpty else { return }

        isSyncing = true
        defer { isSyncing = false }

        do {
            let api = try apiFactory()
            try await api.batchDeleteUserReleases(releases: releases)
            let refreshed = try await api.fetchUserReleases()
            try replaceReleases(with: refreshed, context: context)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // TODO implement a better sync stategy
    private func replaceReleases(with newReleases: [Release], context: ModelContext) throws {
        try context.transaction {
            let existing = try context.fetch(FetchDescriptor<Release>())
            existing.forEach { context.delete($0) }
            newReleases.forEach { context.insert($0) }
            try context.save()
        }
    }
}
