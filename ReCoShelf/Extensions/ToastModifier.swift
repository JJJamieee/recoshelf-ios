//
//  ToastModifier.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/11/22.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let style: ToastStyle
    let duration: Double
    let alignment: Alignment

    func body(content: Content) -> some View {
        ZStack(alignment: alignment) {
            content
            if isPresented {
                ToastView(message: message, style: style)
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation {
                                isPresented = false
                            }
                        }
                    }
            }
        }
    }
}
