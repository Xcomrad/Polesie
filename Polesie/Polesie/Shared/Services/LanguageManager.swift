//
//  LanguageManager.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 21.03.25.
//

import Foundation

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    private let currentLanguageKey = "CurrentLanguageKey"
    let availableLanguages = ["en", "ru"]
    
    @Published var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: currentLanguageKey)
            UserDefaults.standard.synchronize()
            setLanguage()
        }
    }
    
    init() {
        self.currentLanguage = UserDefaults.standard.string(forKey: currentLanguageKey) ?? "en"
        setLanguage()
    }
    
    private func setLanguage() {
        UserDefaults.standard.set([currentLanguage], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "Localized string")
    }
}

