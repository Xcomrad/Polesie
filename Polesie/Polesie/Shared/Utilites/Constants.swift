//
//  Constants.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.03.25.
//

import SwiftUI

enum Constants {
    
    enum Images {
        static let splashImage = "splash"
        static let historyImage = "books.vertical.fill"
        static let traditionsImage = "scroll.fill"
        static let questsImage = "questionmark.bubble.fill"
        static let settingsImage = "gearshape.fill"
    }
    
    enum Colors {
        // Базовые цвета интерфейса
        static let background = Color("BackgroundColor")
        static let text = Color("TextColor")
        static let accent = Color("AccentColor")
        
        // Цвета отражающие атмосферу Полесья
        static let darkGreen = Color("DarkGreen")
        static let earthyBrown = Color("EarthyBrown")
        static let riverBlue = Color("RiverBlue")
        
        // Дополнительные цвета
        static let swampGreen = Color("SwampGreen")
        static let beige = Color("Beige")
        static let stoneGray = Color("StoneGray")
        static let button = Color("ButtonColor")
    }
    
    enum Fonts {
        // Заголовки
        static let h1 = Font.custom("OldStandardTT-Regular", size: 32)
        static let h1Bold = Font.custom("OldStandardTT-Bold", size: 32)
        
        static let h2 = Font.custom("OldStandardTT-Regular", size: 28)
        static let h2Bold = Font.custom("OldStandardTT-Bold", size: 28)
        
        static let h3 = Font.custom("OldStandardTT-Regular", size: 24)
        static let h3Bold = Font.custom("OldStandardTT-Bold", size: 24)
        
        // Основной текст
        static let body = Font.custom("Lora-Regular", size: 20)
        static let bodyBold = Font.custom("Lora-Bold", size: 20)
        static let bodyItalic = Font.custom("Lora-Italic", size: 20)
        
        static let secondary = Font.custom("Lora-Regular", size: 18)
        static let secondaryBold = Font.custom("Lora-Bold", size: 18)
        
        static let caption = Font.custom("Lora-Regular", size: 16)
        static let captionBold = Font.custom("Lora-Bold", size: 16)
        
        // Интерфейс
        static let button = Font.custom("Lora-Bold", size: 18)
        static let small = Font.custom("Lora-Regular", size: 14)
    }
    
    enum Sizes {
        static let cornerRadius: CGFloat = 10
        static let smalPadding: CGFloat = 16
        static let middlePadding: CGFloat = 24
        static let largePadding: CGFloat = 50
        static let onboardingImage: CGFloat = 100
    }
    
    enum Strings {
        // Сплэш
        static let welcomeTitle = String(localized: "welcomeTitle")
        static let welcomeDescription = String(localized: "welcomeDescription")
        static let welcomeDescription1 = String(localized: "welcomeDescription1")
        static let welcomeToOnboarding = String(localized: "welcomeToOnboarding")

        // Онбординг
        static let onboardingWelcomeTitle = String(localized: "onboardingWelcomeTitle")
        static let onboardingWelcomeDescription = String(localized: "onboardingWelcomeDescription")
        static let onboardingHistoryTitle = String(localized: "onboardingHistoryTitle")
        static let onboardingHistoryDescription = String(localized: "onboardingHistoryDescription")
        static let onboardingTraditionsTitle = String(localized: "onboardingTraditionsTitle")
        static let onboardingTraditionsDescription = String(localized: "onboardingTraditionsDescription")
        static let onboardingQuizzesTitle = String(localized: "onboardingQuizzesTitle")
        static let onboardingQuizzesDescription = String(localized: "onboardingQuizzesDescription")
        static let onboardingSettingsTitle = String(localized: "onboardingSettingsTitle")
        static let onboardingSettingsDescription = String(localized: "onboardingSettingsDescription")

        // Кнопки
        static let startJourney = String(localized: "startJuorney")
        static let skipButtonTitle = String(localized: "skipButtonTitle")
        static let startButtonTitle = String(localized: "startButtonTitle")
        static let nextButtonTitle = String(localized: "nextButtonTitle")
        static let backButtonTitle = String(localized: "backButtonTitle")
        static let cancelButtonTitle = String(localized: "cancelButtonTitle")
        static let doneButtonTitle = String(localized: "doneButtonTitle")

        // Таббар
        static let historyButtonTitle = String(localized: "historyButtonTitle")
        static let traditionsButtonTitle = String(localized: "traditionsButtonTitle")
        static let quizzesButtonTitle = String(localized: "quizzesButtonTitle")
        static let settingsButtonTitle = String(localized: "settingsButtonTitle")

        // Настройки
        static let settingsThemeTitle = String(localized: "settingsThemeTitle")
        static let settingsLanguageTitle = String(localized: "settingsLanguageTitle")
        static let settingsLanguage = String(localized: "settingsLanguage")
        static let settingsThemeToggle = String(localized: "settingsThemeToggle")
        static let settingsOnboardingTitle = String(localized: "settingsOnboardingTitle")
        static let settingsOnboardingToggle = String(localized: "settingsOnboardingToggle")
        static let languageName_en = String(localized: "languageName_en")
        static let languageName_ru = String(localized: "languageName_ru")
    }
}
