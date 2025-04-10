//
//  PolesieApp.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.03.25.
//

import SwiftUI

@main
struct PolesieApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var darkModeManager = DarkModeManager()
    @StateObject var fontSizeManager = FontSizeManager()
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    init() {
            persistenceController.preloadTraditionsIfNeeded()
        }
    
    var body: some Scene {
        WindowGroup {

            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(darkModeManager)
                .environmentObject(fontSizeManager)
                .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
        }
    }
}
