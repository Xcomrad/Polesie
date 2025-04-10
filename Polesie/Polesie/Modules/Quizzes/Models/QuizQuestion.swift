//
//  Model.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import Foundation

struct Themes: Codable, Identifiable, Hashable  {
    var id = UUID()
    var allQuizeThemes: [QuizThemes]
}

struct QuizThemes: Codable, Identifiable, Hashable {
    var id = UUID()
    let image: String?
    let name: String
    let description: String
    let questions: [QuizQuestion]
}

struct QuizQuestion: Codable, Identifiable, Hashable {
    var id = UUID()
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    let fact: String
}
