//
//  FontSizeManager.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 22.03.25.
//

import SwiftUI
import Foundation

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

extension FontSizeManager {
    enum FontStyle {
        // Заголовки
        case h1, h1Bold
        case h2, h2Bold
        case h3, h3Bold
        
        // Основной текст
        case body, bodyBold
        case secondary, secondaryBold
        case small
    }
    
    func font(_ style: FontStyle) -> Font {
        let (baseSize, fontName) = configuration(for: style)
        return .custom(fontName, size: baseSize * fontSizeScale)
    }
    
    private func configuration(for style: FontStyle) -> (CGFloat, String) {
        switch style {
            
        case .h1: return (Constants.DynamicFonts.Size.h1, Constants.DynamicFonts.h1)
        case .h1Bold: return (Constants.DynamicFonts.Size.h1, Constants.DynamicFonts.h1Bold)
        case .h2: return (Constants.DynamicFonts.Size.h2, Constants.DynamicFonts.h2)
        case .h2Bold: return (Constants.DynamicFonts.Size.h2, Constants.DynamicFonts.h2Bold)
        case .h3: return (Constants.DynamicFonts.Size.h3, Constants.DynamicFonts.h3)
        case .h3Bold: return (Constants.DynamicFonts.Size.h3, Constants.DynamicFonts.h3Bold)
            
        case .body: return (Constants.DynamicFonts.Size.body, Constants.DynamicFonts.body)
        case .bodyBold: return (Constants.DynamicFonts.Size.body, Constants.DynamicFonts.bodyBold)
        case .secondary: return (Constants.DynamicFonts.Size.secondary, Constants.DynamicFonts.secondary)
        case .secondaryBold: return (Constants.DynamicFonts.Size.secondary, Constants.DynamicFonts.secondaryBold)
        case .small: return (Constants.DynamicFonts.Size.small, Constants.DynamicFonts.small)
        }
    }
}


