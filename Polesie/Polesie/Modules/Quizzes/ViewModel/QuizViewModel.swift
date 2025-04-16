//
//  ViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import SwiftUI

final class QuizViewModel: ObservableObject {
    @Published var quizThemes: [QuizThemesModel] = []
    @Published var selectedAnswer: Int?
    
    @Published var correctAnswersCount = 0
    @Published var currentThemeIndex = 0
    @Published var currentQuestionIndex = 0
    
    @Published var showResult = false
    @Published var showSuccessBage = false
    @Published var isCorrect = false
    @Published var isQuizFinished = false
    
    var currentQuestion: QuizQuestionsModel {
        quizThemes[currentThemeIndex].questions[currentQuestionIndex]
    }
    
    var currentQuestionCount: Int {
        quizThemes[currentThemeIndex].questions.count
    }
    
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
        Task { await fetchData() }
    }
    
    @MainActor
    func fetchData() async {
        do {
            var bundleThemes = try await dataManager.loadDataFromBundle(file: "quizzes", type: [QuizThemesModel].self)
            let passedThemes = try await dataManager.loadPassedThems()

            if let passedThemes = passedThemes {
                for (index, var theme) in bundleThemes.enumerated() {
                    if passedThemes.contains(where: { $0.id == theme.id && $0.hasSuccessBadge }) {
                        theme.hasSuccessBadge = true
                    }
                    bundleThemes[index] = theme
                }
            }
            
            DispatchQueue.main.async {
                self.quizThemes = bundleThemes
            }
        } catch {
            print("Failed to load themes: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Start Quiz
    func startQuize(with theme: QuizThemesModel) {
        if let index = quizThemes.firstIndex(where: { $0.id == theme.id }) {
            currentThemeIndex = index
            currentQuestionIndex = 0
            correctAnswersCount = 0
            resetForNewQuestion()
        }
    }
    
    @MainActor
    func markThemeAsPassed(_ theme: QuizThemesModel) async {
        guard let index = quizThemes.firstIndex(where: { $0.id == theme.id }) else { return }
        quizThemes[index].hasSuccessBadge = true
        
        let passedThemes = quizThemes.filter { $0.hasSuccessBadge }
        try? await dataManager.savePassedThems(passedThemes)
    }
    
    // MARK: - Answer Checking
    func checkAnswer() {
        guard let selected = selectedAnswer else { return }
        isCorrect = selected == currentQuestion.correctAnswerIndex
        if isCorrect {
            correctAnswersCount += 1
        }
        showResult = true
    }
    
    func moveToNextQuestion() {
        if currentQuestionIndex + 1 < currentQuestionCount {
            currentQuestionIndex += 1
            resetForNewQuestion()
        } else {
            isQuizFinished = true
            if correctAnswersCount == currentQuestionCount {
                showSuccessBage = true
                Task {
                    await markThemeAsPassed(quizThemes[currentThemeIndex])
                }
            }
        }
    }
    
    func restartQuiz() {
        currentQuestionIndex = 0
        isQuizFinished = false
        correctAnswersCount = 0
        resetForNewQuestion()
    }
    
    private func resetForNewQuestion() {
        selectedAnswer = nil
        showResult = false
        isCorrect = false
    }
}
