//
//  ThemeToggleButton.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 27.04.25.
//

import SwiftUI

struct ThemeToggleButton: View {
    @EnvironmentObject private var darkModeManager: DarkModeManager
    @Environment(\.colorScheme) var colorScheme
    
    @State private var rotationAngle: Double = 0
    @State private var isPressed: Bool = false
    
    @Binding var isOn: Bool
    
    var body: some View {
        Button {
            withAnimation(.spring(response: Constants.PaddingSizes.p05,
                                  dampingFraction: Constants.PaddingSizes.p05)) {
                darkModeManager.isDarkMode.toggle()
                rotationAngle += 180
                isPressed.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isPressed.toggle()
                }
            }
        } label: {
            Image(systemName: darkModeManager.isDarkMode ? "moon.fill" : "sun.max.fill")
                .font(.system(size: Constants.PaddingSizes.p24))
                .foregroundStyle(Constants.Colors.accent)
                .frame(width: Constants.PaddingSizes.p35,
                       height: Constants.PaddingSizes.p35)
                .background(
                    Circle()
                        .fill(Constants.Colors.background.opacity(Constants.PaddingSizes.p05))
                        .adaptiveShadow(colorScheme: colorScheme)
                )
                .scaleEffect(isPressed ? 0.85 : 1.0)
                .rotationEffect(.degrees(rotationAngle))
                .animation(.spring(response: 0.4, dampingFraction: 0.5), value: isPressed)
                .animation(.spring(response: 0.6, dampingFraction: 0.7), value: rotationAngle)
        }
    }
}
