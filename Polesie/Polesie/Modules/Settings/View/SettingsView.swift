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
        ZStack {
            Constants.Colors.background
                .opacity(Constants.PaddingSizes.opasity)
                .ignoresSafeArea(.all)
            settingsList
        }
    }
    
    // MARK: - Methods
    private var settingsList: some View {
        List {
            themeSection
                .listRowBackground(Constants.Colors.stoneGray.opacity(0.1))
            fontSection
                .listRowBackground(Constants.Colors.stoneGray.opacity(0.1))
        }
        .scrollContentBackground(.hidden)
        .scrollDisabled(true)
    }
    
    private var themeSection: some View {
        Section(header: sectionHeader(Constants.Strings.settingsThemeTitle)) {
            Toggle(Constants.Strings.settingsThemeToggle, isOn: $darkModeManager.isDarkMode)
                .font(Constants.BaseFonts.captionBold)
                .tint(Constants.Colors.accent)
                .animation(.easeInOut, value: darkModeManager.isDarkMode)
        }
    }
    
    private var fontSection: some View {
        Section(header: sectionHeader(Constants.Strings.settingsFontTitle)) {
            Picker(Constants.Strings.settingsFontPicker, selection: $fontSizeManager.userFontSize) {
                ForEach(UserFontSize.allCases) { size in
                    Text(size.localizedName).tag(size)
                }
            }
            .pickerStyle(.menu)
            .font(Constants.BaseFonts.captionBold)
            .tint(Constants.Colors.accent)
        }
    }
    
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(Constants.BaseFonts.small)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SettingsView(vm: SettingsViewModel())
        .environmentObject(DarkModeManager())
        .environmentObject(FontSizeManager())
}
