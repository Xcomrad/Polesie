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
                    icon: "books.vertical",
                    selectedIcon: "books.vertical.fill",
                    isSelected: selectedTab == .history,
                    action: { selectedTab = .history }
                )
                
                TabBarButton(
                    title: Constants.Strings.traditionsButtonTitle,
                    icon: "scroll",
                    selectedIcon: "scroll.fill",
                    isSelected: selectedTab == .traditions,
                    action: { selectedTab = .traditions }
                )
                
                TabBarButton(
                    title: Constants.Strings.quizzesButtonTitle,
                    icon: "questionmark.bubble",
                    selectedIcon: "questionmark.bubble.fill",
                    isSelected: selectedTab == .quizzes,
                    action: { selectedTab = .quizzes }
                )
                
                TabBarButton(
                    title: Constants.Strings.settingsButtonTitle,
                    icon: "gearshape",
                    selectedIcon: "gearshape.fill",
                    isSelected: selectedTab == .settings,
                    action: { selectedTab = .settings }
                )
            }
            .padding(.vertical, Constants.PaddingSizes.p12)
            .padding(.horizontal, Constants.PaddingSizes.p16)
            
            .background(
                BlurView(style: .systemUltraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.PaddingSizes.p24))
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.PaddingSizes.p24)
                            .strokeBorder(Constants.Colors.stoneGray.opacity(0.05), lineWidth: 1)))
            
            .adaptiveShadow(colorScheme: colorScheme)
            .padding(.horizontal, Constants.PaddingSizes.p12)
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}
