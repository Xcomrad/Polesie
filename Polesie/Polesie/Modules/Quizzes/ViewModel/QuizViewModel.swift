////
////  ViewModel.swift
////  Polesie
////
////  Created by Владислав Бут-Гусаим on 30.03.25.
////
//
//import SwiftUI
//
//final class QuizViewModel: ObservableObject {
//    @Published var selectedAnswer: Int?
//    
//    @Published var showResult = false
//    @Published var isCorrect = false
//    @Published var isQuizFinished = false
//    
//    @Published private(set) var score = 0
//    @Published var currentThemeIndex = 0
//    @Published var currentQuestionIndex = 0
//
//    var currentQuestion: QuizQuestion {
//        quizThemes[currentThemeIndex].questions[currentQuestionIndex]
//    }
//    
//    let quizThemes: [QuizThemesModel] = [
//        QuizQuestionsModel(image: "polessie_nature.jpg",
//                   name: "Природа Полесья",
//                   description: "Узнайте о природных богатствах этого региона.",
//                   questions: [
//                    QuizQuestionsModel(text: "Какой национальный парк находится в Полесье?",
//                         options: ["Беловежская пуща", "Припятский", "Лосиный остров", "Русский Север"],
//                         correctAnswerIndex: 1,
//                         fact: "Припятский национальный парк расположен в белорусском Полесье и знаменит своими болотами и биологическим разнообразием."),
//                    QuizQuestionsModel(text: "Какой крупнейший водоём расположен в Полесье?",
//                         options: ["Озеро Нарочь", "Озеро Синее", "Озеро Червонное", "Река Припять"],
//                         correctAnswerIndex: 3,
//                         fact: "Река Припять является одной из главных водных артерий Полесья."),
//                    QuizQuestionsModel(text: "Какое животное считается символом Полесья?",
//                         options: ["Бобр", "Лось", "Рысь", "Волк"],
//                         correctAnswerIndex: 0,
//                         fact: "Бобры широко распространены в водных экосистемах Полесья и играют важную роль в формировании ландшафта."),
//                    QuizQuestionsModel(text: "Какой редкий хищник встречается в Полесье?",
//                         options: ["Бурый медведь", "Лесная куница", "Европейская норка", "Рысь"],
//                         correctAnswerIndex: 3,
//                         fact: "Рысь – редкий, но встречающийся в Полесье хищник, предпочитающий лесные массивы."),
//        ]),
//        
//        QuizThemesModel(image: "folklore_polesie.jpg",
//                   name: "Фольклор и традиции",
//                   description: "Традиционные обряды и культура Полесья.",
//                   questions: [
//                    QuizQuestionsModel(text: "Какой популярный фольклорный персонаж встречается в сказаниях Полесья?",
//                         options: ["Леший", "Кикимора", "Водяной", "Русалка"],
//                         correctAnswerIndex: 0,
//                         fact: "Леший – дух леса, часто упоминаемый в полесском фольклоре."),
//                    QuizQuestionsModel(text: "Как называется традиционный головной убор полесских женщин?",
//                         options: ["Кокошник", "Очипок", "Митра", "Ковпак"],
//                         correctAnswerIndex: 1,
//                         fact: "Очипок – это головной убор замужних женщин в традиционной одежде Полесья."),
//                    QuizQuestionsModel(text: "Какой музыкальный инструмент широко используется в полесской народной музыке?",
//                         options: ["Гусли", "Цимбалы", "Бандура", "Трембита"],
//                         correctAnswerIndex: 1,
//                         fact: "Цимбалы – популярный инструмент в народной музыке Полесья."),
//                    QuizQuestionsModel(text: "Какая традиционная выпечка популярна в Полесье?",
//                         options: ["Калач", "Паляница", "Бабка", "Перепечи"],
//                         correctAnswerIndex: 2,
//                         fact: "Бабка – традиционное блюдо из картофеля, распространённое в Полесье."),
//        ]),
//        
//        QuizThemesModel(image: "history_polesie.jpg",
//                   name: "История Полесья",
//                   description: "Важные исторические события, связанные с регионом.",
//                   questions: [
//                    QuizQuestionsModel(text: "Какое княжество в средневековье контролировало Полесье?",
//                         options: ["Галицко-Волынское", "Новгородское", "Полоцкое", "Смоленское"],
//                         correctAnswerIndex: 0,
//                         fact: "Полесье входило в состав Галицко-Волынского княжества в XII-XIV веках."),
//                    QuizQuestionsModel(text: "Какая известная битва произошла в Полесье во время Великой Отечественной войны?",
//                         options: ["Брестская оборона", "Минское сражение", "Партизанская война", "Бобруйская операция"],
//                         correctAnswerIndex: 2,
//                         fact: "Партизанская война в Полесье была одним из крупнейших очагов сопротивления фашистам."),
//                    QuizQuestionsModel(text: "Какой известный исторический деятель родился в Полесье?",
//                         options: ["Тадеуш Костюшко", "Франциск Скорина", "Янка Купала", "Адам Мицкевич"],
//                         correctAnswerIndex: 0,
//                         fact: "Тадеуш Костюшко, национальный герой Польши и США, родился в окрестностях Полесья."),
//                    QuizQuestionsModel(text: "Какой древний город является важным центром Полесья?",
//                         options: ["Пинск", "Витебск", "Гродно", "Слуцк"],
//                         correctAnswerIndex: 0,
//                         fact: "Пинск – один из древнейших городов Полесья, имеющий богатую историю."),
//        ])
//        ]
//    
//    // MARK: - Actions
//    
//    func startQuize(with theme: QuizThemes) {
//        if let index = quizThemes.firstIndex(where: { $0.name == theme.name }) {
//            currentThemeIndex = index
//            currentQuestionIndex = 0
//            score = 0
//            resetForNewQuestion()
//        }
//    }
//    
//    func checkAnswer() {
//        guard let selected = selectedAnswer else { return }
//        
//        isCorrect = selected == currentQuestion.correctAnswerIndex
//        if isCorrect {
//            score += 1
//        }
//        showResult = true
//    }
//    
//    func moveToNextQuestion() {
//        if currentQuestionIndex + 1 < quizThemes[currentThemeIndex].questions.count {
//            currentQuestionIndex += 1
//        } else {
//            isQuizFinished = true
//        }
//        resetForNewQuestion()
//    }
//    
//    private func resetForNewQuestion() {
//        selectedAnswer = nil
//        showResult = false
//        isCorrect = false
//    }
//    
//    func restartQuiz() {
//        currentQuestionIndex = 0
//        isQuizFinished = false
//        score = 0
//        resetForNewQuestion()
//    }
//}
