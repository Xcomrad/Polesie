//
//  SplashView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.03.25.
//

import SwiftUI

struct SplashView: View {
    @State private var isTextVisible = false
    @State private var showOnboardingView = false
    
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    @EnvironmentObject var darkModeManager: DarkModeManager
    
    var body: some View {
        ZStack {
            Image(Constants.Images.splashImage)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            Constants.Colors.background
                .ignoresSafeArea(.all)
                .opacity(0.5)
            
            VStack(alignment: .center, spacing: Constants.PaddingSizes.middlePadding) {
                Spacer()
                
                if isTextVisible {
                    Text(Constants.Strings.welcomeTitle)
                        .font(Constants.BaseFonts.h1Bold)
                        .foregroundColor(Constants.Colors.text)
                        .multilineTextAlignment(.center)
                        .padding()
                        .transition(.move(edge: .top))
                    
                    Text(Constants.Strings.welcomeDescription)
                        .font(Constants.BaseFonts.captionBold)
                        .foregroundColor(Constants.Colors.text)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text(Constants.Strings.welcomeDescription1)
                        .font(Constants.BaseFonts.captionBold)
                        .foregroundColor(Constants.Colors.text)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text(Constants.Strings.welcomeToOnboarding)
                        .font(Constants.BaseFonts.small)
                        .foregroundColor(Constants.Colors.text)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button(action: {
                        //hasLaunchedBefore = true
                        showOnboardingView = true
                    }) {
                        Text(Constants.Strings.startJourney)
                            .font(Constants.BaseFonts.button)
                            .foregroundColor(Constants.Colors.button)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                Rectangle()
                                    .fill(Constants.Colors.darkGreen)
                            )
                    }
                    .padding(.top, Constants.PaddingSizes.middlePadding)
                }
            }
            .padding(Constants.PaddingSizes.largePadding)
            .onAppear {
                withAnimation(.easeInOut(duration: 2)) {
                    isTextVisible = true
                }
            }
        }
        .fullScreenCover(isPresented: $showOnboardingView) {
            OnboardingView(steps: OnboardingStep.allCases.map { $0.model })
                .environmentObject(DarkModeManager())
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(DarkModeManager())
}
