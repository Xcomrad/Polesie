//
//  PressEvents.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.04.25.
//

import SwiftUI

struct PressEvents: ViewModifier {
    let onPress: () -> Void
    let onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in onPress() }
                    .onEnded { _ in onRelease() })
    }
}

extension View {
    func pressEvents(onPress: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
        self.modifier(PressEvents(onPress: onPress, onRelease: onRelease))
    }
}
