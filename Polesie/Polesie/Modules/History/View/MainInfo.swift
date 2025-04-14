//
//  MainInfo.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 8.04.25.
//

import SwiftUI

struct MainInfo: View {
    @EnvironmentObject var fontSizeManager: FontSizeManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.PaddingSizes.p16) {
                VStack(alignment: .center, spacing: Constants.PaddingSizes.p8) {
                    headerTitile
                    divider
                    secondaryTitle
                    mainText
                }
                .padding(.horizontal, Constants.PaddingSizes.p16)
                .padding(.bottom, Constants.PaddingSizes.p16)
                .contentMargins(.vertical, Constants.PaddingSizes.p24)
            }
        }
    }
    
    // MARK: - Components
    var headerTitile: some View {
        Text("Экран истории")
            .font(fontSizeManager.font(.h1Bold))
            .foregroundStyle(Constants.Colors.text)
            .tracking(1.2)
            .lineSpacing(4)
            .multilineTextAlignment(.center)
            .adaptiveShadow(colorScheme: colorScheme)
            .padding(.top, Constants.PaddingSizes.p16)
    }
    
    var divider: some View {
        Divider()
            .overlay(Constants.Colors.accent
                .opacity(Constants.PaddingSizes.p05))
            .padding(.horizontal, Constants.PaddingSizes.p16)
            .padding(.bottom, Constants.PaddingSizes.p16)
    }
    
    var secondaryTitle: some View {
        Text("Подзаголовок (если надо)")
            .font(fontSizeManager.font(.h3))
            .foregroundColor(.secondary)
            .padding(.horizontal, Constants.PaddingSizes.p24)
    }
    
    var mainText: some View {
        Text("""
            Основной текст про всякую лабуду дубуду дабуди дабудай чтоб было видно много букв.
            Новый абзац с текстом для демонстрации переноса строк и вообще чтобы было все четко, приятно, как в сказке блять у самого счастливого человека под грибами.
            """)
        .font(fontSizeManager.font(.body))
        .foregroundStyle(Constants.Colors.text)
        .lineSpacing(8)
        .tracking(0.4)
        .frame(idealWidth: 320, maxWidth: 480, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
    }
}
