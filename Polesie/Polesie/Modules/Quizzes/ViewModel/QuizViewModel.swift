//
//  ViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import SwiftUI

@MainActor
final class QuizViewModel: ObservableObject {
    @Published var quizThemes: [QuizThemesModel] = []
    @Published var toastMessage: String?
    @Published var toastError: ToastType = .success
    
    @Published var selectedAnswer: Int?
    @Published var correctAnswersCount = 0
    @Published var currentThemeIndex = 0
    @Published var currentQuestionIndex = 0
    
    @Published var showResult = false
    @Published var showSuccessBadge = false
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
    }
    
    // MARK: - Fetch data
    func fetchData() async {
        do {
            var bundleThemes = try await dataManager.loadDataFromBundle(file: "quizzes", type: [QuizThemesModel].self)
            let passedThemesId = (try? await dataManager.loadPassedTheme()) ?? []
            
            bundleThemes = bundleThemes.map { theme in
                var modifiedTheme = theme
                modifiedTheme.hasSuccessBadge = passedThemesId.contains(theme.id)
                return modifiedTheme
            }
                self.quizThemes = bundleThemes
        } catch {
                self.toastMessage = (error as? AppError)?.localizedDescription
                self.toastError = .failure
        }
    }
    
    func markThemeAsPassed(_ theme: QuizThemesModel) async {
        guard let index = quizThemes.firstIndex(where: { $0.id == theme.id }) else { return }
        quizThemes[index].hasSuccessBadge = true
        
        let passedThemesId = quizThemes.filter { $0.hasSuccessBadge }.map { $0.id }
        try? await dataManager.savePassedTheme(passedThemesId)
    }
    
    // MARK: - Start Quiz
    func startQuiz(with theme: QuizThemesModel) {
        if let index = quizThemes.firstIndex(where: { $0.id == theme.id }) {
            currentThemeIndex = index
            currentQuestionIndex = 0
            correctAnswersCount = 0
            resetForNewQuestion()
        }
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
        guard currentQuestionIndex + 1 < currentQuestionCount else {
            isQuizFinished = true
            if correctAnswersCount == currentQuestionCount {
                showSuccessBadge = true
                Task {
                    await markThemeAsPassed(quizThemes[currentThemeIndex])
                }
            }
            return
        }

        currentQuestionIndex += 1
        resetForNewQuestion()
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
