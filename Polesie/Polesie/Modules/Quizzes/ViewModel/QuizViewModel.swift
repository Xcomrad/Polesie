//
//  ViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import SwiftUI

final class QuizViewModel: ObservableObject {
    @Published var selectedAnswer: Int?
    @Published var quizThemes: [QuizThemes] = []
    
    @Published var showResult = false
    @Published var isCorrect = false
    @Published var isQuizFinished = false
    
    @Published private(set) var score = 0
    @Published var currentThemeIndex = 0
    @Published var currentQuestionIndex = 0
    
    private var dataManager: DataManager

    var currentQuestion: QuizQuestions {
        quizThemes[currentThemeIndex].questions[currentQuestionIndex]
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    // MARK: - FetchData
    func fetchData() {
          dataManager.loadData(from: "quizzes", type: [QuizThemes].self) { result in
              DispatchQueue.main.async {
                  switch result {
                  case .success(let themes):
                      self.quizThemes = themes
                  case .failure(let error):
                      print("Ошибка загрузки данных:", error.localizedDescription)
                  }
              }
          }
      }
    
    // MARK: - Actions
    func startQuize(with theme: QuizThemes) {
        if let index = quizThemes.firstIndex(where: { $0.name == theme.name }) {
            currentThemeIndex = index
            currentQuestionIndex = 0
            score = 0
            resetForNewQuestion()
        }
    }
    
    func checkAnswer() {
        guard let selected = selectedAnswer else { return }
        
        isCorrect = selected == currentQuestion.correctAnswerIndex
        if isCorrect {
            score += 1
        }
        showResult = true
    }
    
    func moveToNextQuestion() {
        if currentQuestionIndex + 1 < quizThemes[currentThemeIndex].questions.count {
            currentQuestionIndex += 1
        } else {
            isQuizFinished = true
        }
        resetForNewQuestion()
    }
    
    private func resetForNewQuestion() {
        selectedAnswer = nil
        showResult = false
        isCorrect = false
    }
    
    func restartQuiz() {
        currentQuestionIndex = 0
        isQuizFinished = false
        score = 0
        resetForNewQuestion()
    }
}
