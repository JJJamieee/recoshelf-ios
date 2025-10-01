//
//  WelcomeView.swift
//  ReCoShelf
//
//  Created by Jamie on 2025/10/1.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("ReCoShelf")
                .font(.largeTitle)
            
            TextField("Username", text: .constant(""))
                .textFieldStyle(.roundedBorder)
            
            TextField("Password", text: .constant(""))
                .textFieldStyle(.roundedBorder)
            
            Button(action: {}) {
                Text("Login")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .padding(.top)
        }
        .padding(50)
    }
}

#Preview {
    WelcomeView()
}
