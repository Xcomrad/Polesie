//
//  ResultPopUp.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 14.04.25.
//

import SwiftUI

struct ResultPopUp: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    private var vm: QuizViewModel
    
    init(vm: QuizViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ZStack {
            Constants.Colors.background
                .opacity(Constants.PaddingSizes.p05)
                .ignoresSafeArea()
            
            VStack(spacing: Constants.PaddingSizes.p16) {
                Text("Квиз завершен!")
                    .font(Constants.BaseFonts.h2Bold)
                    .foregroundStyle(Constants.Colors.text)
                
                VStack(alignment: .leading) {
                    Text("Верных ответов: \(vm.correctAnswersCount)")
                        .font(Constants.BaseFonts.body)
                        .foregroundStyle(Constants.Colors.text)
                        .multilineTextAlignment(.center)
                    Text("Всего вопросов: \(vm.currentQuestionCount)")
                        .font(Constants.BaseFonts.body)
                        .foregroundStyle(Constants.Colors.text)
                        .multilineTextAlignment(.center)
                }
                
                Divider()
                    .background(Constants.Colors.text
                        .opacity(0.2))
                
                HStack(spacing: Constants.PaddingSizes.p16) {
                    Button {
                        vm.restartQuiz()
                    } label: {
                        Text("Начать заново")
                            .font(Constants.BaseFonts.small)
                            .foregroundStyle(Constants.Colors.button)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Constants.Colors.accent)
                            .cornerRadius(Constants.PaddingSizes.p12)
                    }
                    
                    Button {
                        dismiss()
                        vm.isQuizFinished = false
                    } label: {
                        Text("На главную")
                            .font(Constants.BaseFonts.small)
                            .foregroundStyle(Constants.Colors.button)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Constants.Colors.earthyBrown)
                            .cornerRadius(Constants.PaddingSizes.p12)
                    }
                }
            }
            .padding(Constants.PaddingSizes.p16)
            .frame(width: Constants.PaddingSizes.p300)
            .background(Constants.Colors.background)
            .cornerRadius(Constants.PaddingSizes.p12)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                    .stroke(Constants.Colors.stoneGray, lineWidth: 1)
            )
            .adaptiveShadow(colorScheme: colorScheme)
        }
        .transition(.opacity)
        .zIndex(2)
    }
}

#Preview {
    ResultPopUp(vm: QuizViewModel(dataManager: DataManager()))
}
