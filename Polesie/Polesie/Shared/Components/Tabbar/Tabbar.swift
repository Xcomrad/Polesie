//
//  Tabbar.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        
        HStack {
            TabBarButton(
                title: "История",
                icon: "books.vertical.fill",
                selectedIcon: Image(systemName: "books.vertical.fill"),
                isSelected: selectedTab == 0,
                action: { selectedTab = 0 }
            )
            
            TabBarButton(
                title: "Традиции",
                icon: "person.2.fill",
                selectedIcon: Image(systemName: "person.2.fill"),
                isSelected: selectedTab == 1,
                action: { selectedTab = 1 }
            )
            
            TabBarButton(
                title: "Квизы",
                icon:"questionmark.square.fill",
                selectedIcon: Image(systemName: "questionmark.square.fill"),
                isSelected: selectedTab == 2,
                action: { selectedTab = 2 }
            )
            
            TabBarButton(
                title: "Настройки",
                icon: "gearshape.fill",
                selectedIcon: Image(systemName: "gearshape.fill"),
                isSelected: selectedTab == 3,
                action: { selectedTab = 3 }
            )
        }
        .padding()
        .background(Constants.Colors.background)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: -5)
    }
}
