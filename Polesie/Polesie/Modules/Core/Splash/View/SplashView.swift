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
    
    @State private var showOnboardingView = false
    @State private var animationStep = 0
    
    var body: some View {
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
            
            VStack {
                Spacer()
                
                VStack(spacing: Constants.PaddingSizes.p24) {
                    
                    greatingsText
                        .opacity(animationStep >= 1 ? 1 : 0)
                        .scaleEffect(animationStep >= 1 ? 1.05 : 1)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    
                    titleText
                        .opacity(animationStep >= 2 ? 1 : 0)
                        .scaleEffect(animationStep >= 2 ? 1.05 : 1)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    
                    subtitleText
                        .opacity(animationStep >= 3 ? 1 : 0)
                        .scaleEffect(animationStep >= 3 ? 1.05 : 1)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    
                    onboardingText
                        .opacity(animationStep >= 4 ? 1 : 0)
                        .scaleEffect(animationStep >= 4 ? 1.05 : 1)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .padding(.horizontal, Constants.PaddingSizes.p50)
                
                
                if animationStep >= 5 {
                    startButton
                        .adaptiveShadow(colorScheme: colorScheme)
                        .padding(Constants.PaddingSizes.p24)
                        .scaleEffect(animationStep >= 5 ? 1.05 : 1)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .padding(Constants.PaddingSizes.p24)
            .onAppear {
                startSplashAnimation()
            }
        }
        .fullScreenCover(isPresented: $showOnboardingView) {
            OnboardingView(steps: OnboardingStep.allCases.map { $0.model })
                .environmentObject(DarkModeManager())
        }
    }
    
    private func startSplashAnimation() {
        withAnimation(.easeOut(duration: Constants.PaddingSizes.p03)) {
            animationStep = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut(duration: Constants.PaddingSizes.p03)) {
                animationStep = 2
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            withAnimation(.easeOut(duration: Constants.PaddingSizes.p03)) {
                animationStep = 3
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.5) {
            withAnimation(.easeOut(duration: Constants.PaddingSizes.p03)) {
                animationStep = 4
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 11.5) {
            withAnimation(.easeOut(duration: Constants.PaddingSizes.p03)) {
                animationStep = 5
            }
        }
    }
    
    // MARK: Components
    private var greatingsText: some View {
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
    
    private var startButton: some View {
        Button {
            withAnimation(.easeInOut(duration: Constants.PaddingSizes.p05)) {
                showOnboardingView = true
                //hasLaunchedBefore = true
            }
        } label: {
            Text(Constants.Strings.startJourney)
                .font(Constants.BaseFonts.button)
                .foregroundColor(Constants.Colors.text)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    Rectangle()
                        .fill(Constants.Colors.darkGreen)
                )
        }
        .padding(.horizontal, Constants.PaddingSizes.p16)
    }
}
