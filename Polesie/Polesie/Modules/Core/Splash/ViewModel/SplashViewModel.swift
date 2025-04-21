//
//  GreetingViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.03.25.
//

import SwiftUI

final class SplashViewModel: ObservableObject {
    @Published var showOnboardingView = false
    @Published var animationStep = 0
    
    @Published var isPressed = false
    @Published var didAppear = false
    @Published var isDismissing = false
    
    func startSplashAnimation() {
        withAnimation(.easeOut(duration: Constants.PaddingSizes.p03)) {
            animationStep = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut(duration: Constants.PaddingSizes.p03)) {
                self.animationStep = 2
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation(.easeOut(duration: Constants.PaddingSizes.p03)) {
                self.animationStep = 3
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            withAnimation(.easeOut(duration: Constants.PaddingSizes.p03)) {
                self.animationStep = 4
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            withAnimation(.easeOut(duration: Constants.PaddingSizes.p03)) {
                self.animationStep = 5
            }
        }
    }
    
    func didStart() {
        self.isPressed = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.isPressed = false
                
                withAnimation {
                    self.isDismissing = true
                }
           
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showOnboardingView = true
                    //hasLaunchedBefore = true
                }
            }
        }
    }
