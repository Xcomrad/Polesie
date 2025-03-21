//
//  SettingsView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var darkModeManager: DarkModeManager
    @EnvironmentObject var languageManager: LanguageManager
    @StateObject private var vm: SettingsViewModel
    
    init(vm: SettingsViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        Form {
            Section(header: Text(Constants.Strings.settingsThemeTitle)
                .font(Constants.Fonts.secondaryBold)) {
                    Toggle(Constants.Strings.settingsThemeToggle, isOn: $darkModeManager.isDarkMode)
                        .font(Constants.Fonts.button)
                }
            
            Section(header: Text(Constants.Strings.settingsLanguageTitle)
                .font(Constants.Fonts.secondaryBold)) {
                    Picker(languageManager.localizedString(forKey: Constants.Strings.settingsLanguage),
                           selection: $languageManager.currentLanguage) {
                        ForEach(languageManager.availableLanguages, id: \.self) { languageCode in
                            Text(self.vm.languageName(for: languageCode))
                                .tag(languageCode)
                        }
                    }
                           .pickerStyle(.menu)
                }
        }
    }
}

#Preview {
    SettingsView(vm: SettingsViewModel())
        .environmentObject(DarkModeManager.shared)
        .environmentObject(LanguageManager.shared)
}


