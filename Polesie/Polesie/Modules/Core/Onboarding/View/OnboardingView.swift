//
//  OnboardingView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 19.03.25.
//

import SwiftUI

struct OnboardingView: View {
    let steps: [OnboardingModel]
    @State private var currentStep = 0
    @State private var showMainView = false
    
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    @EnvironmentObject var darkModeManager: DarkModeManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            // Затемнение фона
            Constants.Colors.background.opacity(0.6)
                .ignoresSafeArea(.all)
            
            VStack {
                // Контент TabView
                TabView(selection: $currentStep) {
                    ForEach(0..<steps.count, id: \.self) { index in
                        VStack {
                            if let imageName = steps[index].image {
                                Image(systemName: imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Constants.Colors.accent)
                                    .frame(width: 100, height: 100)
                            }
                            
                            Text(steps[index].title)
                                .font(Constants.Fonts.h2Bold)
                                .foregroundColor(Constants.Colors.text)
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            Text(steps[index].description)
                                .font(Constants.Fonts.secondary)
                                .foregroundColor(Constants.Colors.text)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)
                            
                            if index == steps.count - 1 {
                                Button(action: {
                                    isOnboardingCompleted = true
                                    showMainView = true
                                }) {
                                    Text("Начать")
                                        .font(Constants.Fonts.button)
                                        .foregroundColor(Constants.Colors.button)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: Constants.Sizes.cornerRadius)
                                                .fill(Constants.Colors.darkGreen)
                                        )
                                }
                                .padding(.top, Constants.Sizes.smalPadding)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: Constants.Sizes.cornerRadius)
                                .fill(Constants.Colors.background)
                                .adaptiveShadow(colorScheme: colorScheme)
                        )
                        .padding(.horizontal, Constants.Sizes.middlePadding)
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack {
                    ForEach(0..<steps.count, id: \.self) { index in
                        Circle()
                            .frame(width: 10, height: 10)
                            .scaleEffect(index == currentStep ? 1.5 : 1)
                            .animation(.easeInOut(duration: 0.3), value: currentStep)
                            .foregroundStyle(index == currentStep ? Constants.Colors.accent : Constants.Colors.beige)
                    }
                }
                .padding(.bottom, Constants.Sizes.middlePadding)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        isOnboardingCompleted = true
                        showMainView = true
                    }) {
                        Text("Пропустить")
                            .font(Constants.Fonts.button)
                            .foregroundColor(Constants.Colors.accent)
                            .padding()
                            .background(
                                Capsule()
                                    .fill(Constants.Colors.background)
                                    .adaptiveShadow(colorScheme: colorScheme)
                            )
                    }
                    .padding(.top, Constants.Sizes.largePadding)
                }
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showMainView) {
            MainView()
                .environmentObject(darkModeManager)
        }
    }
}

#Preview {
    OnboardingView(steps: [OnboardingModel(image: nil,
                                                          title: "Приветствуем на онбординге!",
                                                          description: "Это краткий экскурс по основным механизмам приложения. Вы вольны пропустить его сейчас, но потом можете вернуться в любой момент, через 'Настройки'."),
                                          OnboardingModel(image: "books.vertical.fill",
                                                          title: "История",
                                                          description: "Нажав на нее вы сможете перейти во вкладку истории Полесья."),
                                          OnboardingModel(image: "scroll.fill",
                                                          title: "Традиции",
                                                          description: "Здесь предоставлена информация о трациях, праздниках и культуре Полесья."),
                                          OnboardingModel(image: "questionmark.bubble.fill",
                                                          title: "Квизы!",
                                                          description: "A тут вы сможете проверить свои знания! \nНе беспокойтесь, мы никому не скажем, если ошибетёсь..."),
                                          OnboardingModel(image: "gearshape.fill",
                                                          title: "Настройки",
                                                          description: "Помогут вам настроить приложение по вашему усмотрению.")])
    .environmentObject(DarkModeManager())
}
