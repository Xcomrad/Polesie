//
//  PolesieApp.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.03.25.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct PolesieApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var darkModeManager = DarkModeManager()
    @StateObject private var fontSizeManager = FontSizeManager()
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isOnboardingCompleted {
                MainView(selectedTab: .history)
                    .environmentObject(darkModeManager)
                    .environmentObject(fontSizeManager)
                    .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
            } else {
                SplashView(vm: SplashViewModel())
                    .environmentObject(darkModeManager)
                    .environmentObject(fontSizeManager)
                    .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
            }
        }
    }
}
