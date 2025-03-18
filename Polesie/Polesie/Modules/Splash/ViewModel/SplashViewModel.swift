//
//  GreetingViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.03.25.
//

import Foundation

class SplashViewModel: ObservableObject {
    @Published var navigateToMainView: Bool = false
        
        func startJourney() {
            navigateToMainView = true
        }
}
