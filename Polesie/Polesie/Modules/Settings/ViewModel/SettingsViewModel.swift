//
//  SettingsViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 21.03.25.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    
    func languageName(for code: String) -> String {
        switch code {
        case "en": return Constants.Strings.languageName_en
        case "ru": return Constants.Strings.languageName_ru
        default: return code
        }
    }
}
