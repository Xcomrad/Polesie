//
//  Tab.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 12.04.25.
//

import SwiftUI

enum Tab: Hashable {
    case history, traditions, quizzes, settings
}

class TabCoordinator: ObservableObject {
    @Published var currentTab: Tab = .history
}
