//
//  ReleaseDetailViewModel.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/12/29.
//

import Foundation
import SwiftData

@MainActor
final class ReleaseDetailViewModel: ObservableObject {
    @Published var isSyncing = false
    @Published var errorMessage: String?

    private let apiFactory: () throws -> UserReleaseAPI

    init(apiFactory: @escaping () throws -> UserReleaseAPI = { try UserReleaseAPI() }) {
        self.apiFactory = apiFactory
    }

    // Add the given release to the user's collection.
    // On success, the server response is persisted to SwiftData.
    func addRelease(_ release: Release, context: ModelContext) async {
        guard !isSyncing else { return }

        isSyncing = true
        defer { isSyncing = false }

        do {
            let api = try apiFactory()
            let persistedRelease = try await api.addUserRelease(release: release)
            try saveReleaseToStore(persistedRelease, context: context)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // Persist the server's release into SwiftData, replacing any existing copy.
    private func saveReleaseToStore(_ release: Release, context: ModelContext) throws {
        try context.transaction {
            // Look up any existing release that represents the same remote record.
            let targetID: Int = release.sourceReleaseID
            let predicate = #Predicate<Release> { candidate in
                candidate.sourceReleaseID == targetID
            }
            let descriptor = FetchDescriptor<Release>(predicate: predicate)
            let existing = try context.fetch(descriptor)

            // Remove duplicates so the stored data mirrors the server response.
            existing.forEach { context.delete($0) }

            // Persist the latest release from the API.
            context.insert(release)
            try context.save()
        }
    }
}
