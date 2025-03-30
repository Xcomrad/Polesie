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
        isCorrect ? Constants.Colors.darkGreen :
        isWrong ? Constants.Colors.earthyBrown :
        isSelected ? Constants.Colors.accent : Constants.Colors.text
    }
    
    private var backgroundColor: Color {
        isCorrect ? Constants.Colors.darkGreen.opacity(0.1) :
        isWrong ? Constants.Colors.earthyBrown.opacity(0.1) :
        isSelected ? Constants.Colors.accent.opacity(0.1) : Constants.Colors.background
    }
    
    private var borderColor: Color {
        isCorrect ? Constants.Colors.darkGreen :
        isWrong ? Constants.Colors.earthyBrown :
        isSelected ? Constants.Colors.accent : Constants.Colors.text.opacity(0.2)
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7)) {
                action()
            }
        }) {
            HStack(spacing: Constants.PaddingSizes.smalPadding) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .symbolEffect(.bounce, value: isSelected)
                    .foregroundColor(iconColor)
                    .animation(.easeInOut(duration: 0.3), value: isSelected)
                
                Text(option)
                    .font(Constants.BaseFonts.body)
                    .foregroundColor(Constants.Colors.text)
                    .multilineTextAlignment(.leading)
                    .contentTransition(.opacity)
                
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Constants.PaddingSizes.cornerRadius)
                    .fill(backgroundColor)
                    .animation(.easeInOut(duration: 0.4), value: backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: Constants.PaddingSizes.cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
                    .animation(.easeInOut(duration: 0.3), value: borderColor)
            )
            .scaleEffect(isSelected ? 1.02 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
        }
        .buttonStyle(.plain)
        // Тактильная отдача
        .sensoryFeedback(.selection, trigger: isSelected)
    }
}
