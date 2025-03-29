//
//  EnvoronmentKeys.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 29.03.25.
//

import SwiftUI
// Создаём ключ для доступа к значению
struct SidebarVisibleKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

// Расширяем EnvironmentValues для удобного доступа
extension EnvironmentValues {
    var isSidebarVisible: Binding<Bool> {
        get { self[SidebarVisibleKey.self] }
        set { self[SidebarVisibleKey.self] = newValue }
    }
}
