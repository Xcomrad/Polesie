//
//  OnboardingModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 19.03.25.
//

import SwiftUI

struct OnboardingModel {
    let image: String?
    let title: String
    let description: String
}

enum OnboardingStep: Int, CaseIterable {
    case welcome
    case history
    case traditions
    case quizzes
    case settings
    
    var model: OnboardingModel {
        switch self {
        case .welcome: return OnboardingModel(
            image: nil,
            title: Constants.Strings.onboardingWelcomeTitle,
            description: Constants.Strings.onboardingWelcomeDescription)
            
        case .history: return OnboardingModel(
            image: Constants.Images.historyImage,
            title: Constants.Strings.onboardingHistoryTitle,
            description: Constants.Strings.onboardingHistoryDescription)
            
        case .traditions: return OnboardingModel(
            image: Constants.Images.traditionsImage,
            title: Constants.Strings.onboardingTraditionsTitle,
            description: Constants.Strings.onboardingTraditionsDescription)
            
        case .quizzes: return OnboardingModel(
            image: Constants.Images.questsImage,
            title: Constants.Strings.onboardingQuizzesTitle,
            description: Constants.Strings.onboardingQuizzesDescription)
            
        case .settings: return OnboardingModel(
            image: Constants.Images.settingsImage,
            title: Constants.Strings.onboardingSettingsTitle,
            description: Constants.Strings.onboardingSettingsDescription)
        }
    }
}
