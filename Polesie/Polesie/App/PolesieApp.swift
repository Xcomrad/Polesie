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
    @StateObject var fontSizeManager = FontSizeManager()
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    var body: some Scene {
        WindowGroup {

            SplashView()
                .environmentObject(darkModeManager)
                .environmentObject(fontSizeManager)
                .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
        }
    }
}
