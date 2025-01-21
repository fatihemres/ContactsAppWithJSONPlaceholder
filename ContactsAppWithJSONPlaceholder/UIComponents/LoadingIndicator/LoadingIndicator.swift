//
//  LoadingIndicator.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import SwiftUI

/// A SwiftUI view displaying an animated loading indicator.
/// Combines the `Ring` shape with a gradient and an icon overlay.
struct LoadingIndicator: View {
    @State private var fillPoint = 0.0 // Progress value for the ring.
    
    private var animation: Animation {
        Animation
            .linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        ZStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundColor(.ringTwo)
            
            Ring(fillPoint: fillPoint)
                .stroke(LinearGradient(
                    gradient: Gradient(colors: [.ringOne, .ringTwo]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ), lineWidth: 2.5)
                .frame(width: 100, height: 100)
                .onAppear {
                    withAnimation(self.animation) {
                        self.fillPoint = 1.0
                    }
                }
        }
    }
}

#Preview {
    LoadingIndicator()
}
