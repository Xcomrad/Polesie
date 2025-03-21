//
//  Tabbar.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct TabBar: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedTab: Int
    
    var body: some View {
        
        HStack {
            TabBarButton(
                title: Constants.Strings.historyButtonTitle,
                icon: "books.vertical",
                selectedIcon: "books.vertical.fill",
                isSelected: selectedTab == 0,
                action: { selectedTab = 0 }
            )
            
            TabBarButton(
                title: Constants.Strings.traditionsButtonTitle,
                icon: "scroll",
                selectedIcon: "scroll.fill",
                isSelected: selectedTab == 1,
                action: { selectedTab = 1 }
            )
            
            TabBarButton(
                title: Constants.Strings.quizzesButtonTitle,
                icon: "questionmark.bubble",
                selectedIcon: "questionmark.bubble.fill",
                isSelected: selectedTab == 2,
                action: { selectedTab = 2 }
            )
            
            TabBarButton(
                title: Constants.Strings.settingsButtonTitle,
                icon: "gearshape",
                selectedIcon: "gearshape.fill",
                isSelected: selectedTab == 3,
                action: { selectedTab = 3 }
            )
        }
        .padding(.vertical, Constants.Sizes.cornerRadius)
        .padding(.horizontal, Constants.Sizes.middlePadding)
               .background(
                RoundedRectangle(cornerRadius: Constants.Sizes.cornerRadius)
                       .fill(Constants.Colors.background)
                       .adaptiveShadow(colorScheme: colorScheme)
               )
               .padding(.horizontal, Constants.Sizes.cornerRadius)
    }
}
