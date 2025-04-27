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
        
        static let educationImage = "graduationcap"
        static let educationImageFill = "graduationcap.fill"
        
        static let historyImage = "books.vertical"
        static let historyImageFill = "books.vertical.fill"
        
        static let sideBarImage = "line.3.horizontal"
        static let settingsImage = "gearshape"
        
        static let traditionsImage = "scroll"
        static let traditionsImageFill = "scroll.fill"
        
        static let questsImage = "questionmark.bubble"
        static let questsImageFill = "questionmark.bubble.fill"
        
        static let mapImage = "map"
        static let mapImageFill = "map.fill"
    }
    
    enum Colors {
        // Базовые цвета интерфейса
        static let background = Color("BackgroundColor")
        static let text = Color("TextColor")
        static let accent = Color("AccentColor")
        
        // Цвета отражающие атмосферу Полесья
        static let darkGreen = Color("DarkGreen")
        static let darkRed = Color("DarkRed")
        
        // Дополнительные цвета
        static let stoneGray = Color("StoneGray")
        static let button = Color("ButtonColor")
    }
    
    enum BaseFonts {
        // Заголовки
        static let h1 = Font.custom("OldStandardTT-Regular", size: 30)
        static let h1Bold = Font.custom("OldStandardTT-Bold", size: 30)
        
        static let h2 = Font.custom("OldStandardTT-Regular", size: 26)
        static let h2Bold = Font.custom("OldStandardTT-Bold", size: 26)
        
        static let h3 = Font.custom("OldStandardTT-Regular", size: 22)
        static let h3Bold = Font.custom("OldStandardTT-Bold", size: 2)
        
        // Основной текст
        static let body = Font.custom("Lora-Regular", size: 18)
        static let bodyBold = Font.custom("Lora-Bold", size: 18)
        static let bodyItalic = Font.custom("Lora-Italic", size: 18)
        
        // Второстепенный текст
        static let secondary = Font.custom("Lora-Regular", size: 16)
        static let secondaryBold = Font.custom("Lora-Bold", size: 16)
        
        // Интерфейс
        static let button = Font.custom("Lora-Bold", size: 16)
        static let small = Font.custom("Lora-Regular", size: 12)
        
        // Подписи
        static let caption = Font.custom("Lora-Regular", size: 14)
        static let captionBold = Font.custom("Lora-Bold", size: 14)
    }
    
    enum DynamicFonts {
        // Заголовки
        static let h1 = "OldStandardTT-Regular"
        static let h1Bold = "OldStandardTT-Bold"
        
        static let h2 = "OldStandardTT-Regular"
        static let h2Bold = "OldStandardTT-Bold"
        
        static let h3 = "OldStandardTT-Regular"
        static let h3Bold = "OldStandardTT-Bold"
        
        // Основной текст
        static let body = "Lora-Regular"
        static let bodyBold = "Lora-Bold"
        
        static let secondary = "Lora-Regular"
        static let secondaryBold = "Lora-Bold"
        
        static let caption = "Lora-Regular"
        static let captionBold = "Lora-Bold"
        
        // Интерфейс
        static let button = "Lora-Bold"
        static let small = "Lora-Regular"
        
        // Стоковые размеры шрифта
        enum Size {
            static let h1: CGFloat = 30
            static let h2: CGFloat = 24
            static let h3: CGFloat = 20
            static let body: CGFloat = 16
            static let secondary: CGFloat = 14
            static let small: CGFloat = 12
        }
    }
    
    enum PaddingSizes {
        static let p03: CGFloat = 0.3
        static let p05: CGFloat = 0.5
        static let p8: CGFloat = 8
        static let p12: CGFloat = 12
        static let p16: CGFloat = 16
        static let p24: CGFloat = 24
        static let p35: CGFloat = 35
        static let p50: CGFloat = 50
        static let p80: CGFloat = 80
        static let p100: CGFloat = 100
        static let p120: CGFloat = 120
        static let p200: CGFloat = 200
        static let p250: CGFloat = 250
        static let p300: CGFloat = 300
    }
    
    enum Strings {
        // Сплэш
        static let welcomeTitle = NSLocalizedString("welcomeTitle", comment: "")
        static let welcomeDescription = NSLocalizedString("welcomeDescription", comment: "")
        static let welcomeDescription1 = NSLocalizedString("welcomeDescription1", comment: "")
        static let welcomeToOnboarding = NSLocalizedString("welcomeToOnboarding", comment: "")
        
        // Онбординг
        static let onboardingWelcomeTitle = NSLocalizedString("onboardingWelcomeTitle", comment: "")
        static let onboardingWelcomeDescription = NSLocalizedString("onboardingWelcomeDescription", comment: "")
        
        static let onboardingHistoryTitle = NSLocalizedString("onboardingHistoryTitle", comment: "")
        static let onboardingHistoryDescription = NSLocalizedString("onboardingHistoryDescription", comment: "")
        
        static let onboardingSettingsTitle = NSLocalizedString("onboardingSettingsTitle", comment: "")
        static let onboardingSettingsDescription = NSLocalizedString("onboardingSettingsDescription", comment: "")
        
        static let onboardingTraditionsTitle = NSLocalizedString("onboardingTraditionsTitle", comment: "")
        static let onboardingTraditionsDescription = NSLocalizedString("onboardingTraditionsDescription", comment: "")
        
        static let onboardingQuizzesTitle = NSLocalizedString("onboardingQuizzesTitle", comment: "")
        static let onboardingQuizzesDescription = NSLocalizedString("onboardingQuizzesDescription", comment: "")
        
        static let onboardingPlacesTitle = NSLocalizedString("onboardingPlacesTitle", comment: "")
        static let onboardingPlacesDescription = NSLocalizedString("onboardingPlacesDescription", comment: "")

        
        // Кнопки
        static let startJourney = NSLocalizedString("startJuorney", comment: "")
        static let skipButtonTitle = NSLocalizedString("skipButtonTitle", comment: "")
        static let startButtonTitle = NSLocalizedString("startButtonTitle", comment: "")
        static let nextButtonTitle = NSLocalizedString("nextButtonTitle", comment: "")
        static let backButtonTitle = NSLocalizedString("backButtonTitle", comment: "")
        static let cancelButtonTitle = NSLocalizedString("cancelButtonTitle", comment: "")
        static let doneButtonTitle = NSLocalizedString("doneButtonTitle", comment: "")
        
        // Таббар
        static let historyButtonTitle = NSLocalizedString("historyButtonTitle", comment: "")
        static let themsLabelTitle = NSLocalizedString("themsLabelTitle", comment: "")
        
        static let traditionsButtonTitle = NSLocalizedString("traditionsButtonTitle", comment: "")
        
        static let quizzesButtonTitle = NSLocalizedString("quizzesButtonTitle", comment: "")
        
        static let placesButtonTitle = NSLocalizedString("placesButtonTitle", comment: "")
        
        // Настройки
        static let settingsThemeTitle = NSLocalizedString("settingsThemeTitle", comment: "")
        static let settingsThemeToggle = NSLocalizedString("settingsThemeToggle", comment: "")
        static let settingsFontTitle = NSLocalizedString("settingsFontTitle", comment: "")
        static let settingsFontPicker = NSLocalizedString("settingsFontPicker", comment: "")
        static let settingsOnboardingTitle = NSLocalizedString("settingsOnboardingTitle", comment: "")
        static let settingsOnboardingToggle = NSLocalizedString("settingsOnboardingToggle", comment: "")
    }
}
