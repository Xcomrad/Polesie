//
//  QuizzesCardView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 30.03.25.
//

import SwiftUI

struct QuizzesCardView: View {
    @StateObject var vm: QuizViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Constants.Colors.background.opacity(0.5)
                .ignoresSafeArea(.all)
            
            VStack {
                questionTitle
                    .padding()
                
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
            }
            .padding()
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: vm.showResult)
        }
    }
    
    // MARK: - View Components
    private var questionTitle: some View {
        Text(vm.currentQuestion.text)
            .font(Constants.BaseFonts.h2)
            .foregroundStyle(Constants.Colors.text)
            .multilineTextAlignment(.center)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Constants.PaddingSizes.cornerRadius)
                    .fill(Constants.Colors.background)
                    .adaptiveShadow(colorScheme: colorScheme)
            )
            .transition(.scale(scale: 0.95).combined(with: .opacity))
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
            .cornerRadius(Constants.PaddingSizes.cornerRadius)
            .padding(.horizontal)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.3).delay(0.2), value: vm.showResult)
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
        .padding(.horizontal, Constants.PaddingSizes.smallPadding)
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
                    RoundedRectangle(cornerRadius: Constants.PaddingSizes.cornerRadius)
                        .fill(vm.selectedAnswer == nil ?
                              Constants.Colors.darkGreen.opacity(0.5) :
                                Constants.Colors.darkGreen)
                )
                .scaleEffect(vm.selectedAnswer == nil ? 1.0 : 1.05)
        }
        .disabled(vm.selectedAnswer == nil)
        .animation(.easeInOut(duration: 0.3), value: vm.selectedAnswer)
        .padding(.horizontal)
        .padding(.top, Constants.PaddingSizes.middlePadding)
    }
}

#Preview {
    QuizzesCardView(vm: QuizViewModel())
}
