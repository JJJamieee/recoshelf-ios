//
//  ScanReleaseBarcodeView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/19.
//

import CodeScanner
import SwiftUI

struct ScanReleaseBarcodeView: View {
    @State private var isShowingScanner = false
    @State private var getReleaseSuccess = false
    @State private var resultRelease: Release? = nil
    let apiRoot = Bundle.main.object(forInfoDictionaryKey: "DISCOGS_API_URL") as? String ?? ""
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "DISCOGS_API_KEY") as? String ?? ""
    let apiSecret = Bundle.main.object(forInfoDictionaryKey: "DISCOGS_API_SECRET") as? String ?? ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("Please scan the barcode of the release.")
                    .padding(.bottom)
                
                Button("Scan Code") {
                    isShowingScanner = true
                }
            }
            .padding()
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.ean8, .ean13, .upce], simulatedData: "9802-89201-2", completion: handleScan)
            }
            .navigationDestination(isPresented: $getReleaseSuccess) {
                if let unwrapped = resultRelease {
                    ReleaseDetailView(release: unwrapped)
                }
            }
        }
    }
    
    private func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            print("Found code: \(result.string)")
            
            Task {
                let searchReleases = await searchReleaseByBarcode(result.string)
                
                // TODO needs to check searchReleases
                // TODO should that user choose if multiple
                let releaseData = await getReleaseById(searchReleases[0].id)
                if let unwrapped = releaseData {
                    getReleaseSuccess = true
                    resultRelease = unwrapped.toReleaseModel(barcode: result.string)
                }
            }
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
     }
    
    // TODO: consider move to some where else
    private func searchReleaseByBarcode(_ barcode: String) async -> [SearchResult] {
        guard let url = URL(string: "https://" + apiRoot + "/database/search?barcode=" + barcode) else {
            print("Invalid URL")
            return []
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Discogs key=\(apiKey), secret=\(apiSecret)", forHTTPHeaderField: "Authorization")
        do {
            let (response, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let searchResponse = try decoder.decode(SearchResponse.self, from: response)
            return searchResponse.results
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return []
        }
    }
    
    // TODO: consider move to some where else
    private func getReleaseById(_ id: Int) async -> ReleaseResponse? {
        guard let url = URL(string: "https://" + apiRoot + "/releases/" + String(id)) else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Discogs key=\(apiKey), secret=\(apiSecret)", forHTTPHeaderField: "Authorization")
        do {
            let (response, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let releaseResponse = try decoder.decode(ReleaseResponse.self, from: response)
            return releaseResponse
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return nil
        }
    }
}

#Preview {
    ScanReleaseBarcodeView()
}
