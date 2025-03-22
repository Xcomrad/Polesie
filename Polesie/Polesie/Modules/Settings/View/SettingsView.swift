//
//  SettingsView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var darkModeManager: DarkModeManager
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
        }
    }
}

#Preview {
    SettingsView(vm: SettingsViewModel())
        .environmentObject(DarkModeManager())
}


