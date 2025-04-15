//
//  ViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import SwiftUI

final class QuizViewModel: ObservableObject {
    @Published var selectedAnswer: Int?
    @Published var quizThemes: [QuizThemesModel] = []
    
    @Published var correctAnswersCount = 0
    @Published var currentThemeIndex = 0
    @Published var currentQuestionIndex = 0
    
    @Published var showResult = false
    @Published var showSuccessBage = false
    @Published var isCorrect = false
    @Published var isQuizFinished = false
    
    var currentQuestion: QuizQuestionsModel {
        return quizThemes[currentThemeIndex].questions[currentQuestionIndex]
    }
    
    var currentQuestionCount: Int {
        guard !quizThemes.isEmpty else { return 0 }
        return quizThemes[currentThemeIndex].questions.count
    }
    
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    // MARK: - FetchData
    func fetchBundleData() {
        Task { @MainActor in
            do {
                let data: [QuizThemesModel] = try await dataManager.loadDataFromBundle(file: "quizzes", type: [QuizThemesModel].self)
                let passedThemes = try await dataManager.loadPassedThemes()
                let updatedData = data.map { theme -> QuizThemesModel in
                    var mutableTheme = theme
                    if passedThemes.contains(theme.name) {
                        mutableTheme.hasSuccessBadge = true
                    }
                    return mutableTheme
                }
                
                quizThemes = updatedData
                
            } catch {
                print("ошибка получения данных: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Actions
    func startQuize(with theme: QuizThemesModel) {
        if let index = quizThemes.firstIndex(where: { $0.name == theme.name }) {
            currentThemeIndex = index
            currentQuestionIndex = 0
            correctAnswersCount = 0
            resetForNewQuestion()
        }
    }
    
    func checkAnswer() {
        guard let selected = selectedAnswer else { return }
        
        isCorrect = selected == currentQuestion.correctAnswerIndex
        if isCorrect {
            correctAnswersCount += 1
        }
        showResult = true
    }
    
    func moveToNextQuestion() {
        if currentQuestionIndex + 1 < quizThemes[currentThemeIndex].questions.count {
            currentQuestionIndex += 1
            resetForNewQuestion()
        } else {
            isQuizFinished = true
            if correctAnswersCount == currentQuestionCount {
                markCurrentThemeAsPassed()
            }
        }
    }
    
    private func resetForNewQuestion() {
        selectedAnswer = nil
        showResult = false
        isCorrect = false
    }
    
    func restartQuiz() {
        currentQuestionIndex = 0
        isQuizFinished = false
        correctAnswersCount = 0
        resetForNewQuestion()
    }
    
    func markCurrentThemeAsPassed() {
        Task { @MainActor in
            do {
                var passedThemes = try await dataManager.loadPassedThemes()
                let currentThemeName = quizThemes[currentThemeIndex].name
                passedThemes.insert(currentThemeName)
                try await dataManager.savePassedThemes(passedThemes)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.quizThemes[self.currentThemeIndex].hasSuccessBadge = true
                }
            } catch {
                print("Ошибка при сохранении данных: \(error.localizedDescription)")
            }
        }
    }
}
