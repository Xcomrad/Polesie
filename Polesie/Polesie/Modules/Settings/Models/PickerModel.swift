//
//  PickerModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 22.03.25.
//

import Foundation

enum UserFontSize: String, CaseIterable, Identifiable {
    case tiny = "Крошечный"
    case small = "Небольшой"
    case medium = "Средний"
    case big = "Крупный"
    case huge = "Громадный"
    
    var id: String { self.rawValue }
    
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
