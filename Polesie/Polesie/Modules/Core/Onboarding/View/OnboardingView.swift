//
//  OnboardingView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 19.03.25.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel: OnboardingViewModel
    @EnvironmentObject var darkModeManager: DarkModeManager
    @Environment(\.colorScheme) var colorScheme

    init(steps: [OnboardingModel]) {
        _viewModel = StateObject(wrappedValue: OnboardingViewModel(steps: steps))
    }

    var body: some View {
        ZStack {
            Constants.Colors.background.opacity(0.6)
                .ignoresSafeArea(.all)

            VStack {
                TabView(selection: $viewModel.currentStep) {
                    ForEach(0..<viewModel.steps.count, id: \.self) { index in
                        OnboardingStepView(
                            step: viewModel.steps[index],
                            isLastStep: index == viewModel.steps.count - 1,
                            completeOnboarding: viewModel.completeOnboarding
                        )
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                HStack {
                    ForEach(0..<viewModel.steps.count, id: \.self) { index in
                        Circle()
                            .frame(width: 10, height: 10)
                            .scaleEffect(index == viewModel.currentStep ? 1.5 : 1)
                            .animation(.easeInOut(duration: 0.3), value: viewModel.currentStep)
                            .foregroundStyle(index == viewModel.currentStep ? Constants.Colors.accent : Constants.Colors.beige)
                    }
                }
                .padding(.bottom, Constants.Sizes.middlePadding)
            }

            VStack {
                HStack {
                    Spacer()
                    Button(action: viewModel.skipOnboarding) {
                        Text(Constants.Strings.skipButtonTitle)
                            .font(Constants.Fonts.button)
                            .foregroundColor(Constants.Colors.accent)
                            .padding()
                            .background(
                                Capsule()
                                    .fill(Constants.Colors.background)
                            )
                    }
                    .padding(.top, Constants.Sizes.largePadding)
                    .adaptiveShadow(colorScheme: colorScheme)
                }
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $viewModel.navigateToMainView) {
            MainView()
                .environmentObject(darkModeManager)
        }
    }
}

#Preview {
    OnboardingView(steps: OnboardingStep.allCases.map { $0.model })
    .environmentObject(DarkModeManager())
}
