//
//  OnboardingViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 19.03.25.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var navigateToMainView: Bool = false
    
    func startMain() {
        navigateToMainView = true
    }
}
