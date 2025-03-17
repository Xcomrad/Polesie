//
//  Constants.swift
//  Polecie
//
//  Created by Владислав Бут-Гусаим on 17.03.25.
//

import SwiftUI

enum Constants {
    
    enum Images {
        static let splashImage = "splash"
    }
    
    enum Colors {
        // Базовые цвета интерфейса
        static let background = Color("BackgroundColor")
        static let text = Color("TextColor")
        static let accent = Color("AccentColor") 
        
        //Цвета отражающие атмосферу Полесья
        static let darkGreen = Color("DarkGreen")
        static let earthyBrown = Color("EarthyBrown")
        static let riverBlue = Color("RiverBlue")
        
        //Дополнительные цвета
        static let swampGreen = Color("SwampGreen")
        static let beige = Color("Beige")
        static let stoneGray = Color("StoneGray")
        static let button = Color("ButtonColor")
    }
    
    enum Fonts {
        //Заголовки
        static let h1 = Font.custom("OldStandardTT-Regular", size: 32)
        static let h1Bold = Font.custom("OldStandardTT-Bold", size: 32)
        
        static let h2 = Font.custom("OldStandardTT-Regular", size: 28)
        static let h2Bold = Font.custom("OldStandardTT-Bold", size: 28)
        
        static let h3 = Font.custom("OldStandardTT-Regular", size: 24)
        static let h3Bold = Font.custom("OldStandardTT-Bold", size: 24)
        
        //Основной текст
        static let body = Font.custom("Lora-Regular", size: 20)
        static let bodyBold = Font.custom("Lora-Bold", size: 20)
        static let bodyItalic = Font.custom("Lora-Italic", size: 20)
        
        static let secondary = Font.custom("Lora-Regular", size: 18)
        static let secondaryBold = Font.custom("Lora-Bold", size: 18)
        
        static let caption = Font.custom("Lora-Regular", size: 16)
        static let captionBold = Font.custom("Lora-Bold", size: 16)
        
        //Интерфейс
        static let button = Font.custom("Lora-Bold", size: 18)
        static let small = Font.custom("Lora-Regular", size: 14)
    }
    
    enum Sizes {
        static let smalPadding: CGFloat = 16
        static let middlePadding: CGFloat = 24
        static let largePadding: CGFloat = 50
        static let cornerRadius: CGFloat = 10
    }
}
