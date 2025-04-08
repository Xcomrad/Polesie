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
            VStack(alignment: .leading, spacing: Constants.PaddingSizes.middlePadding) {
                VStack(alignment: .center, spacing: Constants.PaddingSizes.smallPadding) {
                    headerTitile
                    divider
                    secondaryTitle
                    mainText
                }
                .padding(.horizontal, Constants.PaddingSizes.middlePadding)
                .padding(.bottom, Constants.PaddingSizes.middlePadding)
                .contentMargins(.vertical, Constants.PaddingSizes.largePadding)
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
            .padding(.top, Constants.PaddingSizes.middlePadding)
    }
    
    var divider: some View {
        Divider()
            .overlay(Constants.Colors.accent
                .opacity(Constants.PaddingSizes.opasity))
            .padding(.horizontal, Constants.PaddingSizes.middlePadding)
            .padding(.bottom, Constants.PaddingSizes.middlePadding)
    }
    
    var secondaryTitle: some View {
        Text("Подзаголовок (если надо)")
            .font(fontSizeManager.font(.h3))
            .foregroundColor(.secondary)
            .padding(.horizontal, Constants.PaddingSizes.largePadding)
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
