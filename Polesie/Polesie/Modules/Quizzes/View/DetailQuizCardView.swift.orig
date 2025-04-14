//
//  QuizzesCardView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.


import SwiftUI

struct DetailQuizCardView: View {
    @StateObject var vm: QuizViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Constants.Colors.background
                .opacity(Constants.PaddingSizes.p05)
                .ignoresSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    dismissButton
                }
                .padding(.bottom, Constants.PaddingSizes.p24)
                
                questionTitle
                    .padding(.bottom, Constants.PaddingSizes.p12)
                
                quizeProrgeress
                    .padding(.bottom, Constants.PaddingSizes.p12)
                
                answersSection
                    .transition(.move(edge: .leading))
                
                if vm.showResult {
                    resultSection
                        .transition(.asymmetric(
                            insertion: .opacity.combined(with: .move(edge: .bottom)),
                            removal: .opacity
                        ))
                }
                
                nextButton
                    .padding()
            }
<<<<<<< HEAD:Polesie/Polesie/Modules/Quizzes/View/DetailQuizCardView.swift
            .padding(.horizontal, Constants.PaddingSizes.p24)
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: vm.showResult)
            
            if vm.isQuizFinished {
                ResultPopUp(vm: vm)
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .scale(scale: 0.9)),
                        removal: .opacity
                    ))
                    .zIndex(1)
            }
=======
            .padding()
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: vm.showResult)
>>>>>>> main:Polesie/Polesie/Modules/Quizzes/View/QuizzesCardView.swift
        }
        .animation(.easeInOut(duration: Constants.PaddingSizes.p05), value: vm.isQuizFinished)
    }
    
    // MARK: - View Components
    private var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName:"xmark.app.fill")
                .resizable()
                .scaledToFill()
                .frame(width: Constants.PaddingSizes.p24, height: Constants.PaddingSizes.p24)
                .foregroundColor(Constants.Colors.accent)
        }
    }
    
    private var quizeProrgeress: some View {
        HStack {
            ProgressView(value: Double(vm.correctAnswersCount),
                         total: Double(vm.currentQuestionCount))
            .progressViewStyle(.linear)
            .tint(Constants.Colors.darkGreen)
        }
    }
    
    private var questionTitle: some View {
        Text(vm.currentQuestion.text)
            .font(Constants.BaseFonts.h2)
            .foregroundStyle(Constants.Colors.text)
            .multilineTextAlignment(.center)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                    .fill(Constants.Colors.background)
                    .adaptiveShadow(colorScheme: colorScheme)
            )
            .transition(
                .asymmetric(
                    insertion: .scale(scale: 0.95).combined(with: .opacity),
                    removal: .opacity
                )
            )
    }
    
    private var answersSection: some View {
        ForEach(0..<(vm.currentQuestion.options.count), id: \.self) { index in
            answerButton(index)
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .move(edge: .trailing)),
                    removal: .opacity
                ))
        }
    }
    
    private var resultSection: some View {
        Text(vm.currentQuestion.fact)
            .font(Constants.BaseFonts.caption)
            .padding()
            .background(Constants.Colors.beige.opacity(0.2))
            .cornerRadius(Constants.PaddingSizes.p12)
            .padding(.horizontal)
            .transition(
                .asymmetric(
                    insertion: .move(edge: .bottom).combined(with: .opacity),
                    removal: .opacity.animation(.easeIn(duration: 0.2))
                )
            )
    }
    
    //MARK: - Actions
    private func answerButton(_ index: Int) -> some View {
        AnswerButton(
            option: vm.currentQuestion.options[index],
            isSelected: vm.selectedAnswer == index,
            isCorrect: vm.showResult && index == vm.currentQuestion.correctAnswerIndex,
            isWrong: vm.showResult && vm.selectedAnswer == index && !vm.isCorrect
        ) {
            withAnimation(.easeInOut(duration: 0.2)) {
                if !vm.showResult {
                    vm.selectedAnswer = index
                }
            }
        }
    }
    
    private var nextButton: some View {
        Button(action: {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7)) {
                vm.showResult ? vm.moveToNextQuestion() : vm.checkAnswer()
            }
        }) {
            Text(vm.showResult ? "Следующий вопрос" : "Подтвердить ответ")
                .font(Constants.BaseFonts.button)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                        .fill(vm.selectedAnswer == nil ?
                              Constants.Colors.darkGreen.opacity(0.5) :
                                Constants.Colors.darkGreen)
                )
                .scaleEffect(vm.selectedAnswer == nil ? 1.0 : 1.05)
                .animation(.easeInOut(duration: 0.2), value: vm.selectedAnswer)
        }
        .disabled(vm.selectedAnswer == nil)
        .animation(.easeInOut(duration: 0.3), value: vm.selectedAnswer)
    }
}

#Preview {
    DetailQuizCardView(vm: QuizViewModel(dataManager: DataManager()))
}
