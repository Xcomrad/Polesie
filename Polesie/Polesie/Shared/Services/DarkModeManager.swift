//
//  DarkModeManager.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

class DarkModeManager: ObservableObject {
    static let shared = DarkModeManager()
    
    @Published var isDarkMode: Bool {
           didSet {
               UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
               setupTheme()
           }
       }
    
     init() {
           self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
       }
    
    private func setupTheme() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        scene.windows.forEach { window in
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
}

