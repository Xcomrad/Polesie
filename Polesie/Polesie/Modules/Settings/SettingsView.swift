//
//  SettingsView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var darkModeManager: DarkModeManager
    
    var body: some View {
        
            Form {
                Section(header: Text("Настройка темы")
                    .font(Constants.Fonts.secondaryBold)) {
                        Toggle("Сменить тему", isOn: $darkModeManager.isDarkMode)
                            .font(Constants.Fonts.button)
                    }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(DarkModeManager())
}


