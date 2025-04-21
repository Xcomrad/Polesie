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
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .font(Constants.BaseFonts.button)
                    .foregroundStyle(isSelected ? Constants.Colors.background : Constants.Colors.text)
                    .padding(.vertical, Constants.PaddingSizes.p16)
                    .padding(.horizontal, Constants.PaddingSizes.p24)
                    .background(
                        ZStack {
                            if isSelected {
                                Constants.Colors.accent
                                    .clipShape(RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12))
                                    .adaptiveShadow(colorScheme: colorScheme)
                            } else {
                                Constants.Colors.background
                                    .clipShape(RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12))
                            }
                        }
                    )
                    .scaleEffect(isPressed ? 0.95 : 1.0)
            }
            .buttonStyle(PlainButtonStyle())
            .pressEvents(
                onPress: { withAnimation { isPressed = true } },
                onRelease: { withAnimation { isPressed = false } })
        }
    }
}
