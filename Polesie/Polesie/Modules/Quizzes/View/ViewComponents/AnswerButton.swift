//
//  QuizzesButton.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import SwiftUI

struct AnswerButton: View {
    let option: String
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let action: () -> Void
    
    private var iconColor: Color {
        if isCorrect { return Constants.Colors.darkGreen }
        if isWrong { return Constants.Colors.darkRed }
        return isSelected ? Constants.Colors.accent : Constants.Colors.text.opacity(0.7)
    }
    
    private var iconImage: String {
        if isCorrect { return "checkmark.circle.fill" }
        if isWrong { return "xmark.circle.fill" }
        return isSelected ? "circle.fill" : "circle"
    }
    
    private var backgroundColor: Color {
        if isCorrect { return Constants.Colors.darkGreen.opacity(0.08) }
        if isWrong { return Constants.Colors.darkRed.opacity(0.08) }
        return isSelected ? Constants.Colors.accent.opacity(0.08) : Constants.Colors.background
    }
    
    private var borderColor: Color {
        if isCorrect { return Constants.Colors.darkGreen.opacity(Constants.PaddingSizes.p03) }
        if isWrong { return Constants.Colors.darkRed.opacity(Constants.PaddingSizes.p03) }
        return isSelected ? Constants.Colors.accent.opacity(Constants.PaddingSizes.p03) : Constants.Colors.text.opacity(0.1)
    }
    
    private var borderWidth: CGFloat {
        isSelected ? 1.5 : 1.0
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Constants.PaddingSizes.p12) {
                Image(systemName: iconImage)
                    .font(.system(size: 22))
                    .foregroundColor(iconColor)
                    .transition(.opacity)
                
                Text(option)
                    .font(Constants.BaseFonts.body)
                    .foregroundColor(Constants.Colors.text)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer(minLength: 0)
            }
            .padding(Constants.PaddingSizes.p16)
            .background(
                RoundedRectangle(cornerRadius: Constants.PaddingSizes.p16)
                    .fill(backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: Constants.PaddingSizes.p16)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .scaleEffect(isSelected ? 1.02 : 1.0)
            .animation(.spring(), value: isSelected)
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isSelected)
        .sensoryFeedback(.success, trigger: isCorrect)
        .sensoryFeedback(.error, trigger: isWrong)
        .accessibilityHint(isCorrect ? "Правильный ответ" : isWrong ? "Неправильный ответ" : "")
    }
}
