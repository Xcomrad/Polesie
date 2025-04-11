//
//  Model.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import Foundation

struct QuizThemesModel: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    let image: String?
    let name: String
    let description: String
    let questions: [QuizQuestionsModel]

    private enum CodingKeys: String, CodingKey {
        case image, name, description, questions
    }
}

struct QuizQuestionsModel: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    let fact: String
    
    private enum CodingKeys: String, CodingKey {
        case text, options, correctAnswerIndex, fact
    }
}
