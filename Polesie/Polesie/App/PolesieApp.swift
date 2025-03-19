//
//  PolesieApp.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.03.25.
//

import SwiftUI

@main
struct PolesieApp: App {
    @StateObject private var darkModeManager = DarkModeManager()
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    var body: some Scene {
        WindowGroup {
//            if isOnboardingCompleted {
//                MainView()
//                    .environmentObject(darkModeManager)
//                    .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
//            } else {
//                OnboardingView(steps: steps)
//            }
            SplashView()
                .environmentObject(darkModeManager)
                .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)
        }
    }
}

let steps: [OnboardingModel] = [OnboardingModel(image: "books.vertical.fill",
                                           title: "История",
                                           description: "Нажав на нее вы сможете перейти во вкладку истории Полесья и всякой неведомой херни."),
                           OnboardingModel(image: "scroll.fill",
                                           title: "Традиции",
                                           description: "Здесь предоставлена информация о трациях, праздниках и культуре Полесья."),
                           OnboardingModel(image: "questionmark.bubble.fill",
                                           title: "Квизы!",
                                           description: "A тут вы сможете проверить свои знания! \nНе беспокойтесь, мы никому не скажем, если ошибетёсь..."),
                           OnboardingModel(image: "gearshape.fill",
                                           title: "Настройки",
                                           description: "Помогут вам настроить приложение по вашему усмотрению."),
]
