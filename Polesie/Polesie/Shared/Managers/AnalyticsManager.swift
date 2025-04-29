//
//  AnalyticsManager.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 29.04.25.
//

import Foundation
import Firebase

enum AnalyticsManager {
    static func trackEvent(_ event: AnalyticEvent, parameters: [String: Any]? = nil) {
        Analytics.logEvent(event.rawValue, parameters: parameters)
    }
    
    enum AnalyticEvent: String {
       
        case onboardingSkipped = "onboarding_skipped"
        case onboardingFinished = "onboarding_finished"
        
        // Main
        case mainOpened = "main_screen_opened"
        case sidebarOpened = "sidebar_screen_opened"
        case settingsOpened = "settings_screen_opened"
        case themeSelected = "theme_selected"
        case fontChanged = "font_changed"
        
        // Tradition
        case traditionOpened = "tradition_opened"
        case subthemesButtonTapped = "subthemes_button_tapped"
        case traditionFavorited = "tradition_favorited"
        
        // Quiz
        case quizeOpened = "quize_opened"
        case selectQuiz = "select_quiz"
        case quizStarted = "quiz_started"
        case quizeRestart = "quiz_restart"
        case quizeOnMenu = "quiz_on_menu"
        case quizFinished = "quiz_finished"
        case quizAnswerSelected = "quiz_answer_selected"
        
        // Place
        case placeOpened = "place_opened"
        case annotationTapped = "annotation_tapped"
        case annotationOverview = "annotation_overview"
        case navigationStarted = "navigation_started"
        case toSiteButtonTapped = "to_site_button_tapped"
        case placeFavorited = "place_favorited"

        // Other
        case overviewScrolled = "overview_scrolled"
        case shareTapped = "share_tapped"
    }
}
