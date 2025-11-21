//
//  ToastStyle.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/11/22.
//

import SwiftUI

enum ToastStyle {
    case success
    case failed
}

extension ToastStyle {
    var backgroundColor: Color {
        switch self {
        case .success:
            return .mint
        case .failed:
            return .red
        }
    }
    
    var textColor: Color {
        .white
    }
    
    var iconName: String {
        switch self {
        case .success:
            return "checkmark"
        case .failed:
            return "x.circle"
        }
    }
}
