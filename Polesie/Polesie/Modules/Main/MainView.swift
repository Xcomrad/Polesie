//
//  MainView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var darkModeManager: DarkModeManager
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        VStack {
            switch selectedTab {
            case 0: HistoryView()
            case 1: TraditionsView()
            case 2: QuizzesView()
            case 3: SettingsView(vm: SettingsViewModel())
            default: HistoryView()
            }
            
            TabBar(selectedTab: $selectedTab)
        }
        .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
    }
}

#Preview {
    MainView()
        .environmentObject(DarkModeManager.shared)
        .environmentObject(LanguageManager.shared)
}
