//
//  CardsView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 14.04.25.
//

import SwiftUI

struct CardsView: View {
    let theme: QuizThemesModel
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedTheme: QuizThemesModel?
    
    @State private var isPressed = false
    @State private var isVisible = false
    
    var body: some View {
        Button {
            selectedTheme = theme
        } label: {
            ZStack(alignment: .bottom) {
                VStack(alignment: .center, spacing: Constants.PaddingSizes.p8) {
                    quizName
                    quizeDescription
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(colors: [Constants.Colors.background,
                                            Constants.Colors.background.opacity(Constants.PaddingSizes.p05)],
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .cornerRadius(Constants.PaddingSizes.p12)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                        .stroke(Constants.Colors.stoneGray.opacity(Constants.PaddingSizes.p05),
                                lineWidth: Constants.PaddingSizes.p05)
                )
                .opacity(isVisible ? 1 : 0)
                .animation(.easeOut(duration: 0.2), value: isVisible)
                
                if theme.hasSuccessBadge {
                    successBage
                        .padding(Constants.PaddingSizes.p8)
                }
            }
        }
        .onAppear {
            withAnimation {
                isVisible = true
            }
        }
        .adaptiveShadow(colorScheme: colorScheme)
        .buttonStyle(.plain)
    }
    
    // MARK: - Card Components
    private var quizName: some View {
        Text(theme.name)
            .font(Constants.BaseFonts.captionBold)
            .foregroundStyle(Constants.Colors.text)
            .multilineTextAlignment(.center)
    }
    
    private var quizeDescription: some View {
        Text(theme.description)
            .font(Constants.BaseFonts.small)
            .foregroundStyle(Constants.Colors.text)
            .multilineTextAlignment(.leading)
            .truncationMode(.tail)
    }
    
    private var successBage: some View {
        Text("ПРОЙДЕН")
            .font(Constants.BaseFonts.bodyBold)
            .foregroundColor(Constants.Colors.darkGreen)
            .padding(.vertical, Constants.PaddingSizes.p05)
            .padding(.horizontal, Constants.PaddingSizes.p8)
            .padding(Constants.PaddingSizes.p8)
            .background(
                Rectangle()
                    .stroke(Constants.Colors.darkGreen, lineWidth: 2)
            )
            .rotationEffect(.degrees(Constants.PaddingSizes.p12))
            .offset(x: 16, y: -16)
        
    }
}
