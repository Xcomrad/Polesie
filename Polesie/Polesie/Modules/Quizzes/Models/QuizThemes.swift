//
//  Model.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import Foundation

struct QuizThemesModel: Codable, Identifiable, Hashable {
    var id = UUID()
    let image: String?
    let name: String
    let description: String
    let questions: [QuizQuestionsModel]
}

struct QuizQuestionsModel: Codable, Identifiable, Hashable {
    var id = UUID()
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    let fact: String
}
