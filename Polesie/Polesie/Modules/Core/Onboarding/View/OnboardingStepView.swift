//
//  OnboardingStepView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 20.03.25.
//

import SwiftUI

struct OnboardingStepView: View {
    let step: OnboardingModel
    let isLastStep: Bool
    let completeOnboarding: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            
            icon
            title
            description
   
            if isLastStep {
                startButton
                .padding(.top, Constants.PaddingSizes.p8)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                .fill(Constants.Colors.background)
                .adaptiveShadow(colorScheme: colorScheme)
        )
        .padding(.horizontal, Constants.PaddingSizes.p16)
    }
    
    // MARK: - Components
    private var icon: some View {
        Image(systemName: step.image)
            .resizable()
            .scaledToFit()
            .foregroundStyle(Constants.Colors.accent)
            .frame(width: Constants.PaddingSizes.p80,
                   height: Constants.PaddingSizes.p80)
    }
    
    private var title: some View {
        Text(step.title)
            .font(Constants.BaseFonts.h2Bold)
            .foregroundColor(Constants.Colors.text)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    private var description: some View {
        Text(step.description)
            .font(Constants.BaseFonts.secondary)
            .foregroundColor(Constants.Colors.text)
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
    }
    
    // MARK: - Action
    private var startButton: some View {
        Button(action: {
            AnalyticsManager.trackEvent(.onboardingFinished)
            completeOnboarding()
        }) {
            Text(Constants.Strings.startButtonTitle)
                .font(Constants.BaseFonts.button)
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                        .fill(Constants.Colors.darkGreen)
                )
        }
    }
}
