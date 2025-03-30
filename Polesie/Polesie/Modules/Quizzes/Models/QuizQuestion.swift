//
//  Model.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import Foundation

struct QuizQuestion: Codable, Identifiable {
    var id = UUID()
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    let fact: String
}

struct QuizSession {
    var questions: [QuizQuestion]
    var currentQuestionIndex = 0
    var score = 0
    var isCompleted: Bool { currentQuestionIndex >= questions.count }
    
    var currentQuestion: QuizQuestion? {
        guard questions.indices.contains(currentQuestionIndex) else { return nil }
        return questions[currentQuestionIndex]
    }
    
    mutating func moveToNextQuestion() {
        currentQuestionIndex += 1
    }
}
