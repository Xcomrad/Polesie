//
//  MapAnnotationView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 23.04.25.
//

import SwiftUI

struct MapAnnotationView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isSelected = false
    @State private var isPressed = false
    
    let imageName: String
    let title: String
    let action: () -> Void
    
    private var shadowColor: Color {
        colorScheme == .dark ? .white.opacity(Constants.PaddingSizes.p05) :
            .black.opacity(Constants.PaddingSizes.p05)
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.bouncy(duration: Constants.PaddingSizes.p03,
                                  extraBounce: Constants.PaddingSizes.p03)) {
                isSelected.toggle()
                action()
            }
        }) {
            VStack(spacing: Constants.PaddingSizes.p8) {
                imageContent
                selectionIndicator
            }
        }
        .buttonStyle(ScaleButtonStyle(isPressed: $isPressed))
    }
    
    // MARK: - Components
    private var imageContent: some View {
        ZStack {
            if isSelected {
                Circle()
                    .fill(Constants.Colors.accent
                        .opacity(Constants.PaddingSizes.p03))
                    .frame(width: Constants.PaddingSizes.p100, height: Constants.PaddingSizes.p100)
                    .blur(radius: 6)
            }
            
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: Constants.PaddingSizes.p80,
                       height: Constants.PaddingSizes.p80)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [.white, .accent],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: isSelected ? 3 : 2
                        )
                )
                .background(
                    Circle()
                        .fill(Material.ultraThinMaterial)
                )
                .scaleEffect(isPressed ? 0.9 : isSelected ? 1.1 : 1.0)
                .shadow(
                    color: shadowColor,
                    radius: isSelected ? 10 : 5,
                    x: 0,
                    y: isSelected ? 5 : 2
                )
        }
    }
    
    private var selectionIndicator: some View {
        Image(systemName: "arrowtriangle.down.fill")
            .font(.system(size: Constants.PaddingSizes.p12))
            .foregroundColor(Constants.Colors.accent)
            .scaleEffect(isSelected ? 1.5 : 1.0)
            .opacity(isSelected ? 1 : 0)
            .animation(.easeInOut(duration: Constants.PaddingSizes.p03),
                       value: isSelected)
    }
}

struct ScaleButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: Constants.PaddingSizes.p03), value: configuration.isPressed)
    
    }
}
#Preview {
    MapAnnotationView(imageName: "pinsk", title: "Пинск", action: {  })
}
