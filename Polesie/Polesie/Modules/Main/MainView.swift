//
//  MainView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    @State private var isSidebarVisible = false
    @EnvironmentObject var darkModeManager: DarkModeManager
    
    var body: some View {
        ZStack {
            Group {
                switch selectedTab {
                case 0: HistoryView()
                case 1: TraditionsView()
                case 2: QuizzesView(vm: QuizViewModel())
                case 3: SettingsView(vm: SettingsViewModel())
                default: HistoryView()
                }
            }
            .environment(\.isSidebarVisible, $isSidebarVisible)
            
            if !isSidebarVisible {
                TabBar(selectedTab: $selectedTab)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: isSidebarVisible)
        .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
    }
}

#Preview {
    MainView()
        .environmentObject(DarkModeManager())
}
