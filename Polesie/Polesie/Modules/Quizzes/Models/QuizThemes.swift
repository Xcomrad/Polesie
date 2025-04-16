//
//  Model.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import Foundation

struct QuizThemesModel: Codable, Identifiable, Hashable {
    let id: Int
    let image: String?
    let name: String
    let description: String
    var hasSuccessBadge = false
    let questions: [QuizQuestionsModel]

    private enum CodingKeys: String, CodingKey {
        case id, image, name, description, questions
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
