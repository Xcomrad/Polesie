//
//  FontSizeManager.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 22.03.25.
//

import SwiftUI

class FontSizeManager: ObservableObject {
    @Published var userFontSize: UserFontSize {
        didSet {
            save()
        }
    }
    
    init() {
        let rawValue = UserDefaults.standard.string(forKey: "userFontSize") ?? ""
        self.userFontSize = UserFontSize(rawValue: rawValue) ?? .medium
    }
    
    
    func save() {
        UserDefaults.standard.set(userFontSize.rawValue, forKey: "userFontSize")
    }
    
    var fontSizeScale: CGFloat {
        userFontSize.scale
    }
}
