//
//  AdaptiveShadow.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 19.03.25.
//

import SwiftUI

extension View {
    func adaptiveShadow(colorScheme: ColorScheme) -> some View {
        self.shadow(
            color: colorScheme == .dark ? .white.opacity(0.2) : .black.opacity(0.2),
            radius: 3, x: 0, y: 3
        )
    }
}
