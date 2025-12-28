//
//  UserReleaseAPI.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/12/28.
//

import Foundation

struct UserReleaseAPI {
    // TODO move to somewhere for sharing usage
    enum APIError: LocalizedError {
        case missingBaseURL
        case invalidURL
        case requestFailed(statusCode: Int)
        case decodingFailed

        var errorDescription: String? {
            switch self {
            case .missingBaseURL:
                return "Missing base URL."
            case .invalidURL:
                return "Could not build the URL from the configured base URL."
            case .requestFailed(let statusCode):
                return "Server request failed with status code \(statusCode)."
            case .decodingFailed:
                return "Failed to decode response."
            }
        }
    }

    private let baseURL: URL
    private let session: URLSession

    init(session: URLSession = .shared) throws {
        guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: "RECOSHELF_API_URL") as? String,
        let baseURL = URL(string: baseURLString) else {
            throw APIError.missingBaseURL
        }

        self.baseURL = baseURL
        self.session = session
    }

    func fetchUserReleases() async throws -> [Release] {
        guard let endpoint = URL(string: "/v1/me/releases", relativeTo: baseURL) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, 200 == httpResponse.statusCode else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw APIError.requestFailed(statusCode: statusCode)
        }

        let decoder = JSONDecoder()
        do {
            let payload = try decoder.decode([UserReleaseResponse].self, from: data)
            return payload.map { $0.toReleaseModel() }
        } catch {
            print("Error decoding JSON: \(error)")
            throw APIError.decodingFailed
        }
    }
}

private struct UserReleaseResponse: Decodable {
    let id: Int
    let sourceReleaseID: Int
    let title: String
    let country: String
    let genres: [String]
    let releaseYear: Int
    let tracklist: [UserTrackResponse]
    let images: String?
    
    func toReleaseModel() -> Release {
        let imageURL: URL?
        if let images {
            imageURL = URL(string: images)
        } else {
            imageURL = nil
        }
        
        return Release(
            id: id,
            sourceReleaseID: sourceReleaseID,
            title: title,
            artists: [],
            releaseYear: String(releaseYear),
            country: country,
            genres: genres,
            tracklist: tracklist.enumerated().map { index, track in
                Track(position: String(index + 1), duration: track.duration, title: track.title)
            },
            imageURL: imageURL
        )
    }
}

private struct UserTrackResponse: Decodable {
    let duration: String
    let title: String
}
