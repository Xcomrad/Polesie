//
//  OnboardingView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 19.03.25.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var vm: OnboardingViewModel
    @EnvironmentObject var darkModeManager: DarkModeManager
    @Environment(\.colorScheme) var colorScheme
    
    init(steps: [OnboardingModel]) {
        _vm = StateObject(wrappedValue: OnboardingViewModel(steps: steps))
    }
    
    var body: some View {
        ZStack {
            Constants.Colors.background.opacity(0.6)
                .ignoresSafeArea(.all)
            
            VStack {
                TabView(selection: $vm.currentStep) {
                    ForEach(0..<vm.steps.count, id: \.self) { index in
                        OnboardingStepView(
                            step: vm.steps[index],
                            isLastStep: index == vm.steps.count - 1,
                            completeOnboarding: vm.completeOnboarding
                        )
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack {
                    ForEach(0..<vm.steps.count, id: \.self) { index in
                        Circle()
                            .frame(width: 10, height: 10)
                            .scaleEffect(index == vm.currentStep ? 1.5 : 1)
                            .animation(.easeInOut(duration: 0.3), value: vm.currentStep)
                            .foregroundStyle(index == vm.currentStep ? Constants.Colors.accent : Constants.Colors.beige)
                    }
                }
                .padding(.bottom, Constants.PaddingSizes.middlePadding)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: vm.skipOnboarding) {
                        Text(Constants.Strings.skipButtonTitle)
                            .font(Constants.BaseFonts.button)
                            .foregroundColor(Constants.Colors.accent)
                            .padding()
                            .background(
                                Capsule()
                                    .fill(Constants.Colors.background)
                            )
                    }
                    .padding(.top, Constants.PaddingSizes.largePadding)
                    .adaptiveShadow(colorScheme: colorScheme)
                }
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $vm.navigateToMainView) {
            MainView()
                .environmentObject(darkModeManager)
        }
    }
}

#Preview {
    OnboardingView(steps: OnboardingStep.allCases.map { $0.model })
        .environmentObject(DarkModeManager())
}
