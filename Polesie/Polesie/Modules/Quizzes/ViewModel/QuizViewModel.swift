//
//  ViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import SwiftUI

final class QuizViewModel: ObservableObject {
    @Published var selectedAnswer: Int?
    @Published var showResult = false
    @Published var isCorrect = false
    @Published private(set) var score = 0
    
    private(set) var question: QuizQuestion = .init(
        text: "Какое растение является символом Полесья?",
        options: ["Клюква", "Папоротник", "Верба", "Осина"],
        correctAnswerIndex: 0,
        fact: "Клюква - традиционная ягода Полесья, собираемая на болотах"
    )
    
    // MARK: - Actions
    func checkAnswer() {
        guard let selected = selectedAnswer else { return }
        
        isCorrect = selected == question.correctAnswerIndex
        if isCorrect {
            score += 1
        }
        showResult = true
    }
    
    func moveToNextQuestion() {
        // пока так
        resetForNewQuestion()
    }
    
    private func resetForNewQuestion() {
        selectedAnswer = nil
        showResult = false
        isCorrect = false
    }
}
