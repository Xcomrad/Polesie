//
//  TabBarButton.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//


import SwiftUI

struct TabBarButton: View {
    let title: String
    let icon: String
    let selectedIcon: String
    var isSelected: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? selectedIcon : icon)
                    .font(.system(size: Constants.PaddingSizes.p24))
                    .foregroundStyle(isSelected ? Constants.Colors.accent : Constants.Colors.stoneGray)
                
                Text(title)
                    .font(Constants.BaseFonts.small)
                    .foregroundStyle(isSelected ? Constants.Colors.accent : Constants.Colors.stoneGray)
            }
            .scaleEffect(isSelected ? 1.2 : 1.0)
            .animation(.spring(response: Constants.PaddingSizes.p05, dampingFraction: 0.7, blendDuration: 0), value: isSelected)
            .frame(maxWidth: .infinity)
        }
    }
}
