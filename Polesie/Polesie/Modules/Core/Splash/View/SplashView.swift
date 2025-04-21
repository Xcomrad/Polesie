//
//  SplashView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.03.25.
//

import SwiftUI

struct SplashView: View {
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject var vm: SplashViewModel
    
    init(vm: SplashViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ZStack {
            backgroundLayer
            contentLayer
                .padding(Constants.PaddingSizes.p24)
                .onAppear {
                    vm.startSplashAnimation()
                    vm.didAppear = true
                }
        }
        .opacity(vm.didAppear && !vm.isDismissing ? 1 : 0)
        .animation(.easeInOut(duration: 1.0), value: vm.isDismissing)
        
        .fullScreenCover(isPresented: $vm.showOnboardingView) {
            OnboardingView(steps: OnboardingStep.allCases.map { $0.model })
                .environmentObject(DarkModeManager())
        }
    }
    
    // MARK: Background layer
    private var backgroundLayer: some View {
        ZStack {
            Image(Constants.Images.splashImage)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            LinearGradient(colors: [.clear, Constants.Colors.background
                .opacity(Constants.PaddingSizes.p05),
                                    Constants.Colors.background],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea(.all)
        }
    }
    
    // MARK: Content layer
    private var contentLayer: some View {
        VStack {
            Spacer()
            VStack(spacing: Constants.PaddingSizes.p24) {
                
                greetingsText
                    .opacity(vm.animationStep >= 1 ? 1 : 0)
                    .scaleEffect(vm.animationStep >= 1 ? 1.05 : 1)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: vm.animationStep)
                
                titleText
                    .opacity(vm.animationStep >= 2 ? 1 : 0)
                    .scaleEffect(vm.animationStep >= 2 ? 1.05 : 1)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: vm.animationStep)
                
                subtitleText
                    .opacity(vm.animationStep >= 3 ? 1 : 0)
                    .scaleEffect(vm.animationStep >= 3 ? 1.05 : 1)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: vm.animationStep)
                
                onboardingText
                    .opacity(vm.animationStep >= 4 ? 1 : 0)
                    .scaleEffect(vm.animationStep >= 4 ? 1.05 : 1)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: vm.animationStep)
            }
            .padding(.horizontal, Constants.PaddingSizes.p50)
            
            
            if vm.animationStep >= 5 {
                startButton
                    .adaptiveShadow(colorScheme: colorScheme)
                    .padding(Constants.PaddingSizes.p24)
                    .scaleEffect(vm.animationStep >= 5 ? 1.05 : 1)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 1.5), value: vm.isDismissing)
    }
    
    // MARK: Components
    private var greetingsText: some View {
        Text(Constants.Strings.welcomeTitle)
            .font(Constants.BaseFonts.h1Bold)
            .foregroundColor(Constants.Colors.text)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
    
    private var titleText: some View {
        Text(Constants.Strings.welcomeDescription)
            .font(Constants.BaseFonts.captionBold)
            .foregroundColor(Constants.Colors.text)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
    
    private var subtitleText: some View {
        Text(Constants.Strings.welcomeDescription1)
            .font(Constants.BaseFonts.captionBold)
            .foregroundColor(Constants.Colors.text)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
    
    private var onboardingText: some View {
        Text(Constants.Strings.welcomeToOnboarding)
            .font(Constants.BaseFonts.small)
            .foregroundColor(Constants.Colors.text)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
    
    // MARK: - Action
    private var startButton: some View {
        Button {
            vm.didStart()
            
        } label: {
            Text(Constants.Strings.startJourney)
                .font(Constants.BaseFonts.button)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    Rectangle()
                        .fill(Constants.Colors.darkGreen)
                )
        }
        .padding(.horizontal, Constants.PaddingSizes.p16)
        .scaleEffect(vm.isPressed ? 0.95 : 1)
        .animation(.spring(response: 0.3, blendDuration: 0.6), value: vm.isPressed)
    }
}
