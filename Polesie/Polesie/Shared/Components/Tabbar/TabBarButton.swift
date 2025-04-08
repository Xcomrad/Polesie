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
                    .font(.system(size: Constants.PaddingSizes.largePadding))
                    .foregroundStyle(isSelected ? Constants.Colors.accent : Constants.Colors.stoneGray)
                    .scaleEffect(isSelected ? 1.2 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0), value: isSelected)
                
                
                Text(title)
                    .font(Constants.BaseFonts.small)
                    .foregroundStyle(isSelected ? Constants.Colors.accent : Constants.Colors.stoneGray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
