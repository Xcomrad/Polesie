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
            if let imageName = step.image {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Constants.Colors.accent)
                    .frame(width: Constants.PaddingSizes.p100,
                           height: Constants.PaddingSizes.p100)
            }
            
            Text(step.title)
                .font(Constants.BaseFonts.h2Bold)
                .foregroundColor(Constants.Colors.text)
                .multilineTextAlignment(.center)
                .padding()
            
            Text(step.description)
                .font(Constants.BaseFonts.secondary)
                .foregroundColor(Constants.Colors.text)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            
            if isLastStep {
                Button(action: completeOnboarding) {
                    Text(Constants.Strings.startButtonTitle)
                        .font(Constants.BaseFonts.button)
                        .foregroundColor(Constants.Colors.button)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                                .fill(Constants.Colors.darkGreen)
                        )
                }
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
}
