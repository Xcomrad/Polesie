//
//  Model.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import Foundation

struct Themes:Codable, Identifiable, Hashable {
    var id = UUID()
    var quizThemes: [QuizThemes]
}

struct QuizThemes: Codable, Identifiable, Hashable {
    var id = UUID()
    let image: String?
    let name: String
    let description: String
    let questions: [QuizQuestions]
}

struct QuizQuestions: Codable, Identifiable, Hashable {
    var id = UUID()
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    let fact: String
}
