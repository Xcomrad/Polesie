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
    @ObservedObject var vm: SettingsViewModel
    
    var body: some View {
        ZStack {
            Constants.Colors.background
                .opacity(Constants.PaddingSizes.p05)
                .ignoresSafeArea(.all)
            settingsList
        }
        .onAppear {
            AnalyticsManager.trackEvent(.settingsOpened)
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
            HStack {
                Text(Constants.Strings.settingsThemeToggle)
                    .font(Constants.BaseFonts.captionBold)
                Spacer()
                ThemeToggleButton(isOn: $darkModeManager.isDarkMode)
            }
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
