//
//  GreetingViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.03.25.
//

import Foundation

class SplashViewModel: ObservableObject {
    @Published var navigateToOnboardingView: Bool = false
        
        func startOnboarding() {
            navigateToOnboardingView = true
        }
}
