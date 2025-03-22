//
//  SettingsView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var darkModeManager: DarkModeManager
    @EnvironmentObject var fontSizeManager: FontSizeManager
    @StateObject private var vm: SettingsViewModel
    
    init(vm: SettingsViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        Form {
            Section(header: Text(Constants.Strings.settingsThemeTitle)
                .font(Constants.BaseFonts.small)) {
                    Toggle(Constants.Strings.settingsThemeToggle, isOn: $darkModeManager.isDarkMode)
                        .font(Constants.BaseFonts.button)
                }
            
            Section(header: Text(Constants.Strings.settingsFontTitle)
                .font(Constants.BaseFonts.small)) {
                    Picker(Constants.Strings.settingsFontPicker, selection: $fontSizeManager.userFontSize) {
                        ForEach(UserFontSize.allCases) { size in
                            Text(size.rawValue).tag(size)
                        }
                    }
                    .pickerStyle(.menu)
                }
        }
    }
}

#Preview {
    SettingsView(vm: SettingsViewModel())
        .environmentObject(DarkModeManager())
        .environmentObject(FontSizeManager())
}


