//
//  ResultPopUp.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 14.04.25.
//

import SwiftUI

struct ResultPopUp: View {
    var text: String
    var score: String?
    var description: String?
    var onRestart: (() -> Void)?
    var onMenu: (() -> Void)?
    
    @Environment(\.colorScheme) var colorScheme
    @State private var appearAnimation = false
    
    var body: some View {
        ZStack {
            backgroundLayer
            
            ZStack {
                ConfettiView()
                    .ignoresSafeArea(.all)
                
                VStack(spacing: Constants.PaddingSizes.p16) {
                    descriptionLayer
                    divider
                    buttons
                }
                .padding(Constants.PaddingSizes.p16)
                .frame(maxWidth: Constants.PaddingSizes.p300)
                .background(Constants.Colors.background)
                .cornerRadius(Constants.PaddingSizes.p12)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                        .stroke(Constants.Colors.stoneGray, lineWidth: 0.5)
                )
                .adaptiveShadow(colorScheme: colorScheme)
                .scaleEffect(appearAnimation ? 1 : 0.9)
                .opacity(appearAnimation ? 1 : 0)
                .onAppear {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        appearAnimation = true
                        triggerExplosion()
                    }
                }
            }
            .zIndex(1)
        }
        .transition(.opacity)
        .zIndex(1)
    }
    
    // MARK: - Components
    private var backgroundLayer: some View {
        BlurView(style: .systemUltraThinMaterial)
            .ignoresSafeArea(.all)
            .opacity(appearAnimation ? 1 : 0)
            .animation(.easeInOut(duration: Constants.PaddingSizes.p03), value: appearAnimation)
    }
    
    private var descriptionLayer: some View {
        VStack(alignment: .center) {
            makeText(text, font: Constants.BaseFonts.h2Bold,
                     color: Constants.Colors.text)
            .padding(.bottom, Constants.PaddingSizes.p16)
            
            VStack(alignment: .leading) {
                if let score, !score.isEmpty {
                    makeText(score, font: Constants.BaseFonts.body,
                             color: Constants.Colors.text)
                }
                
                if let description, !description.isEmpty {
                    makeText(description, font: Constants.BaseFonts.secondaryBold,
                             color: Constants.Colors.text)
                }
            }
        }
    }
    
    private var divider: some View {
        Divider()
            .background(Constants.Colors.text
                .opacity(Constants.PaddingSizes.p03))
    }
    
    private var buttons: some View {
        HStack(spacing: Constants.PaddingSizes.p16) {
            
            if let onRestart {
                submitButtons(Constants.Strings.restart, onRestart, .quizeRestart)
            }
            
            if let onMenu {
                submitButtons(Constants.Strings.toTests, onMenu, .quizeOnMenu)
            }
        }
    }
    
    // MARK: - Actions
    private func makeText(_ text: String, font: Font, color: Color) -> some View {
        Text(text)
            .font(font)
            .foregroundStyle(color)
    }
    
    private func submitButtons(_ text: String, _ closure: @escaping () -> Void, _ buttonType: AnalyticsManager.AnalyticEvent) -> some View {
        Button(action:  {
            AnalyticsManager.trackEvent(buttonType)
            closure()
        }) {
            Text(text)
                .font(Constants.BaseFonts.small)
                .foregroundStyle(Constants.Colors.button)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Constants.Colors.accent)
                .cornerRadius(Constants.PaddingSizes.p12)
        }
    }
    
    private func triggerExplosion() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.PaddingSizes.p05) {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
        }
    }
}
