//
//  MainView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            switch selectedTab {
            case 0: HistoryView()
            case 1: TraditionsView()
            case 2: QuizzesView()
            case 3: SettingsView()
            default: HistoryView()
            }
            
            TabBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    MainView()
}
