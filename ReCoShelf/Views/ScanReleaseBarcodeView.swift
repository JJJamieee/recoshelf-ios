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

    var body: some View {
        VStack {
            Text("Please scan the barcode of the release.")
                .padding(.bottom)
            
            Button("Scan Code") {
                isShowingScanner = true
            }
        }
        .padding()
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.ean8, .ean13, .upce], simulatedData: "4988005521234", completion: handleScan)
        }
    }
    
    private func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            print("Found code: \(result.string)")
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
     }
}

#Preview {
    ScanReleaseBarcodeView()
}
