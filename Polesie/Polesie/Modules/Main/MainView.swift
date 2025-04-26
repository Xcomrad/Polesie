//
//  MainView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab: Tab
    @State private var isSidebarVisible = false
    @State private var isTabBarVisible = true
    
    @StateObject private var historyViewModel: HistoryViewModel = HistoryViewModel(dataManager: DataManager())
    @StateObject private var traditionsViewModel = TraditionsViewModel(dataManager: DataManager())
    @StateObject private var quizViewModel = QuizViewModel(dataManager: DataManager())
    @StateObject private var placesViewModel = PlacesViewModel(dataManager: DataManager())
    
    @EnvironmentObject var darkModeManager: DarkModeManager
    @EnvironmentObject var fontSizeManager: FontSizeManager
    @StateObject var mapManager = MapManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Group {
                    switch selectedTab {
                    case .history: HistoryView(vm: historyViewModel)
                    case .traditions: TraditionsView(vm: traditionsViewModel)
                    case .quizzes: QuizzesView(vm: quizViewModel)
                    case .places: MapView(vm: placesViewModel, mapManager: mapManager)
                    }
                }
                .environment(\.isTabBarVisible, $isTabBarVisible)
                .environment(\.isSidebarVisible, $isSidebarVisible)
                .environmentObject(fontSizeManager)
                
                if isTabBarVisible && !isSidebarVisible {
                    TabBar(selectedTab: $selectedTab)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut, value: isTabBarVisible)
            .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
        }
    }
}
