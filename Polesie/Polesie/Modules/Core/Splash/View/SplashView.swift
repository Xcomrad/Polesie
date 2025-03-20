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
            
            VStack(alignment: .center, spacing: Constants.Sizes.middlePadding) {
                Spacer()
                
                if isTextVisible {
                    Text("Добро пожаловать в Полесье!")
                        .font(Constants.Fonts.h1Bold)
                        .foregroundColor(Constants.Colors.text)
                        .multilineTextAlignment(.center)
                        .padding()
                        .transition(.move(edge: .top))
                    
                    Text("Погрузитесь в уникальный мир Полесья — края лесов, болот и богатой культуры.")
                        .font(Constants.Fonts.secondaryBold)
                        .foregroundColor(Constants.Colors.text)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("Узнайте о традициях, истории и достопримечательностях этого удивительного региона.")
                        .font(Constants.Fonts.secondaryBold)
                        .foregroundColor(Constants.Colors.text)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("Перед началом, мы рекомендуем пройти небольшой онбординг, чтобы в дальшейшем было проще ориентироваться в приложении.")
                        .font(Constants.Fonts.small)
                        .foregroundColor(Constants.Colors.text)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button(action: {
                        //hasLaunchedBefore = true
                        showOnboardingView = true
                    }) {
                        Text("Начать путешествие")
                            .font(Constants.Fonts.button)
                            .foregroundColor(Constants.Colors.button)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                Rectangle()
                                    .fill(Constants.Colors.darkGreen)
                            )
                    }
                    .padding(.top, Constants.Sizes.middlePadding)
                }
            }
            .padding(Constants.Sizes.largePadding)
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
