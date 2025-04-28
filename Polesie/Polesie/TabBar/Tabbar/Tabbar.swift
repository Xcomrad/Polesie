//
//  Tabbar.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct TabBar: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TabBarButton(
                    title: Constants.Strings.historyButtonTitle,
                    icon: Constants.Images.educationImage,
                    selectedIcon: Constants.Images.educationImageFill,
                    isSelected: selectedTab == .history,
                    action: { selectedTab = .history }
                )
                
                TabBarButton(
                    title: Constants.Strings.traditionsButtonTitle,
                    icon: Constants.Images.traditionsImage,
                    selectedIcon: Constants.Images.traditionsImageFill,
                    isSelected: selectedTab == .traditions,
                    action: { selectedTab = .traditions }
                )
                
                TabBarButton(
                    title: Constants.Strings.quizzesButtonTitle,
                    icon: Constants.Images.questsImage,
                    selectedIcon: Constants.Images.questsImageFill,
                    isSelected: selectedTab == .quizzes,
                    action: { selectedTab = .quizzes }
                )
                
                TabBarButton(
                    title: Constants.Strings.placesButtonTitle,
                    icon: Constants.Images.mapImage,
                    selectedIcon: Constants.Images.mapImageFill,
                    isSelected: selectedTab == .places,
                    action: { selectedTab = .places }
                )
            }
            .padding(.vertical, Constants.PaddingSizes.p12)
            .padding(.horizontal, Constants.PaddingSizes.p16)
            
            .background(
                Constants.Colors.background
                    .clipShape(RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12))
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                            .strokeBorder(Constants.Colors.accent.opacity(0.05), lineWidth: 1)))
            
            .padding(.horizontal, Constants.PaddingSizes.p12)
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .adaptiveShadow(colorScheme: colorScheme)
    }
}
