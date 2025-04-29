//
//  AnalyticsManager.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 29.04.25.
//

import Foundation
import Firebase

enum AnalyticsManager {
    static func trackScreen(_ screen: AnalyticScreen) {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: screen.rawValue,
            AnalyticsParameterScreenClass: screen.rawValue
        ])
    }
    
    static func trackButtonTap(_ button: AnalyticButton) {
        Analytics.logEvent("button_tap", parameters: [
            "button_name": button.rawValue
        ])
    }
    
    static func trackEvent(_ event: AnalyticEvent, parameters: [String: Any]? = nil) {
        Analytics.logEvent(event.rawValue, parameters: parameters)
    }
    
    enum AnalyticScreen: String {
        case main = "main_screen"
        case sidebar = "sidebar_screen"
        case settings = "settings_screen"
        
        case traditions = "traditions_screen"
        case traditionsDetails = "tradition_details_screen"
        
        case quizzes = "quizzes_screen"
        case places = "places_screen"
        case overView = "overview_screen"
        case placeDetails = "place_details_screen"
    }
    
    enum AnalyticButton: String {
        case finishOnboarding = "finish_onboarding"
        case skipOnboarding = "skip_onboarding"
        
        case favorite = "favorite"
        case switchMode = "switch_mode"
        case switchFont = "switch_font"
        
        case selectQuiz = "select_quiz"
        case backToQuizzes = "back_to_quizzes"
        case tryAgain = "try_again"
        case tryNext = "try_next"
        
        case centerMap = "center_map"
        case centerUserLocation = "center_user_location"
        case mapAnnotation = "map_annotation"
        case overView = "over_view"
        case mapAnnotationDetails = "map_annotation_details"
        case onNavigate = "on_navigate"
    }
    
    enum AnalyticEvent: String {
        case onboardingSkipped = "onboarding_skipped"
        case onboardingFinished = "onboarding_finished"

        case placeOpened = "place_opened"
        case placeFavorited = "place_favorited"
        case navigationStarted = "navigation_started"

        case traditionOpened = "tradition_opened"

        case quizStarted = "quiz_started"
        case quizFinished = "quiz_finished"
        case quizAnswerSelected = "quiz_answer_selected"

        case overviewScrolled = "overview_scrolled"

        case themeChanged = "theme_changed"
        case fontChanged = "font_changed"

        case shareTapped = "share_tapped"
    }
}
