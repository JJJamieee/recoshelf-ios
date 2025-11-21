//
//  ToastView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/11/22.
//

import SwiftUI

struct ToastView: View {
    let message: String
    let style: ToastStyle

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: style.iconName)
                .foregroundColor(style.textColor)

            Text(message)
                .font(.subheadline)
                .foregroundColor(style.textColor)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(style.backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    ToastView(message: "Add Success!", style: .success)
}
