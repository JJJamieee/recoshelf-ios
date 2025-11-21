//
//  ToastExtension.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/11/22.
//

import SwiftUI

extension View {
    func toast(isPresented: Binding<Bool>, message: String, style: ToastStyle, duration: Double = 2.0, alignment: Alignment = .bottom) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message, style: style, duration: duration, alignment: alignment))
    }
}
