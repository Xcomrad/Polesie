//
//  PickerModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 22.03.25.
//

import Foundation

enum UserFontSize: String, CaseIterable, Identifiable {
    case tiny = "tiny"
    case small = "small"
    case medium = "medium"
    case big = "big"
    case huge = "huge"
    
    var id: String { self.rawValue }
    
    var localizedName: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
    
    var scale: CGFloat {
        switch self {
        case .tiny: return 0.70
        case .small: return 0.85
        case .medium: return 1.0
        case .big: return 1.15
        case .huge: return 1.30
        }
    }
}
