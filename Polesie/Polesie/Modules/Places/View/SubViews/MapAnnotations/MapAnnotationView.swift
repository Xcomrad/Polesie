//
//  MapAnnotationView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 23.04.25.
//

import SwiftUI

struct MapAnnotationView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let imageName: String
    let action: () -> Void
    
    private var shadowColor: Color {
        colorScheme == .dark ? .white.opacity(Constants.PaddingSizes.p05) :
            .black.opacity(Constants.PaddingSizes.p05)
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.bouncy(duration: Constants.PaddingSizes.p03,
                                  extraBounce: Constants.PaddingSizes.p03)) {
                AnalyticsManager.trackEvent(.annotationTapped)
                action()
            }
        }) {
            VStack(spacing: Constants.PaddingSizes.p8) {
                imageContent
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
    
    // MARK: - Components
    private var imageContent: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: Constants.PaddingSizes.p50,
                       height: Constants.PaddingSizes.p50)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [.white, .accent],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
                .background(
                    Circle()
                        .fill(Material.ultraThinMaterial)
                )
                .shadow(
                    color: shadowColor,
                    radius: 5,
                    x: 2,
                    y: 2
                )
        }
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.5 : 1.0)
            .animation(.easeOut(duration: Constants.PaddingSizes.p03), value: configuration.isPressed)
    }
}
