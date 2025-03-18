//
//  PolesieApp.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.03.25.
//

import SwiftUI

@main
struct PolesieApp: App {
    @StateObject private var darkModeManager = DarkModeManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(darkModeManager)
                .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
        }
    }
}
