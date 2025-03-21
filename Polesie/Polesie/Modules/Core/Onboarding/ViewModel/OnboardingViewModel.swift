//
//  OnboardingViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 19.03.25.
//

import SwiftUI

protocol OnboardingViewModelInput {
    func moveToNextStep()
    func completeOnboarding()
    func skipOnboarding()
}


final class OnboardingViewModel: ObservableObject, OnboardingViewModelInput {
    let steps: [OnboardingModel]
    @Published var currentStep: Int = 0
    @Published var isOnboardingCompleted: Bool = false
    @Published var navigateToMainView: Bool = false

    init(steps: [OnboardingModel]) {
        self.steps = steps
    }

    func moveToNextStep() {
        if currentStep < steps.count - 1 {
            currentStep += 1
        } else {
            completeOnboarding()
        }
    }

    func completeOnboarding() {
        isOnboardingCompleted = true
        navigateToMainView = true
    }

    func skipOnboarding() {
        navigateToMainView = true
    }
}
