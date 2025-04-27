//
//  SidebarButton.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 23.03.25.
//

import SwiftUI

struct SidebarButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    let title: String
    var isSelected: Bool
    let action: () -> Void
    
    @State private var isPressed = false
    @State private var shadowPulse = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Constants.BaseFonts.button)
                .foregroundStyle(isSelected ? Constants.Colors.background : Constants.Colors.text)
                .padding(.vertical, Constants.PaddingSizes.p16)
                .padding(.horizontal, Constants.PaddingSizes.p24)
                .background(
                    RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                        .fill(isSelected ? Constants.Colors.accent : Constants.Colors.background)
                        .overlay(
                            RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                                .strokeBorder(gradientBorder, lineWidth: isSelected ? 2 : 1)
                        )
                        .shadow(color: .text.opacity(Constants.PaddingSizes.p05),
                                radius: isSelected ? (shadowPulse ? 6 : 3) : 3,
                                x: 2, y: 2)
                )
                .scaleEffect(isPressed ? 0.90 : 1.0)
                .animation(.spring(response: Constants.PaddingSizes.p05, dampingFraction: 0.6), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear { startShadowPulseIfNeeded() }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation { isPressed = true }
                }
                .onEnded { _ in
                    withAnimation { isPressed = false }
                }
        )
    }
    
    // MARK: - Helpers
    private var gradientBorder: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Constants.Colors.accent,
                Constants.Colors.accent.opacity(Constants.PaddingSizes.p05)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private func startShadowPulseIfNeeded() {
        guard isSelected else { return }
        
        withAnimation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
            shadowPulse.toggle()
        }
    }
}
