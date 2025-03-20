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
        // Кнопки
        static let skipButtonTitle = "Пропустить"
        static let startButtonTitle = "Начать"
        static let nextButtonTitle = "Далее"
        static let backButtonTitle = "Назад"
        static let cancelButtonTitle = "Отмена"
        static let doneButtonTitle = "Готово"
        
        // Онбординг
        static let onboardingWelcomeTitle = "Приветствуем на онбординге!"
        static let onboardingWelcomeDescription = "Это краткий экскурс по основным механизмам приложения. Вы вольны пропустить его сейчас, но потом можете вернуться в любой момент, через 'Настройки'."
        static let onboardingHistoryTitle = "История"
        static let onboardingHistoryDescription = "Нажав на нее вы сможете перейти во вкладку истории Полесья."
        static let onboardingTraditionsTitle = "Традиции"
        static let onboardingTraditionsDescription = "Здесь предоставлена информация о трациях, праздниках и культуре Полесья."
        static let onboardingQuizzesTitle = "Квизы!"
        static let onboardingQuizzesDescription = "A тут вы сможете проверить свои знания! \nНе беспокойтесь, мы никому не скажем, если ошибетесь..."
        static let onboardingSettingsTitle = "Настройки"
        static let onboardingSettingsDescription = "Помогут вам настроить приложение по вашему усмотрению."
        
        // Настройки
        static let settingsThemeTitle = "Настройка темы"
        static let settingsThemeToggle = "Сменить тему"
        static let settingsOnboardingTitle = "Обучение"
        static let settingsOnboardingToggle = "Пройти заново"
    }
}
