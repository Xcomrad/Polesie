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
    @EnvironmentObject var fontSizeManager: FontSizeManager
    @Environment(\.colorScheme) var colorScheme
    
    init(steps: [OnboardingModel]) {
        _vm = StateObject(wrappedValue: OnboardingViewModel(steps: steps))
    }
    
    var body: some View {
        ZStack {
            backgroundLayer
            tabView
            skipButton
        }
        .fullScreenCover(isPresented: $vm.navigateToMainView) {
            MainView(selectedTab: .history)
                .environmentObject(darkModeManager)
        }
    }
    
    // MARK: - Components
    private var backgroundLayer: some View {
        LinearGradient(colors: [.clear, Constants.Colors.background
            .opacity(Constants.PaddingSizes.p05),
            Constants.Colors.background],
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea(.all)
    }
    
    private var tabView: some View {
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
                        .foregroundStyle(index == vm.currentStep ? Constants.Colors.accent : Constants.Colors.stoneGray)
                }
            }
            .padding(.bottom, Constants.PaddingSizes.p16)
        }
    }
    
    // MARK: - Action
    private var skipButton: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: vm.skipOnboarding) {
                    Text(Constants.Strings.skipButtonTitle)
                        .font(Constants.BaseFonts.button)
                        .foregroundColor(Constants.Colors.text)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                                .fill(Constants.Colors.background)
                        )
                }
                .padding(.top, Constants.PaddingSizes.p24)
                .padding(.trailing, Constants.PaddingSizes.p24)
                .adaptiveShadow(colorScheme: colorScheme)
            }
            Spacer()
        }
    }
}
