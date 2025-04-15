//
//  SidebarButton.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 23.03.25.
//

import SwiftUI

struct SidebarButton: View {
    let title: String
    let isSelected: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .font(Constants.BaseFonts.button)
                    .foregroundStyle(Constants.Colors.button)
                    .padding()
                    .background(Constants.Colors.accent)
                    .multilineTextAlignment(.leading)
                    .cornerRadius(Constants.PaddingSizes.p12)
            }
        }
    }
}
