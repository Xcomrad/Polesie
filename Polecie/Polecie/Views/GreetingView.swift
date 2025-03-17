//
//  ContentView.swift
//  Polecie
//
//  Created by Владислав Бут-Гусаим on 17.03.25.
//

import SwiftUI

struct GreetingView: View {
    
    @State private var isTextVisible = false
    
    var body: some View {
        ZStack {
            Image("main.background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 24) {
                Spacer()
                if isTextVisible {
                    Text("Добро пожаловать в Полесье!")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.7), radius: 10, x: 0, y: 5)
                        .multilineTextAlignment(.center)
                        .padding()
                        .transition(.move(edge: .top))
                    
                    Text("Погрузитесь в уникальный мир Полесья — края лесов, болот и богатой культуры.")
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("Узнайте о традициях, истории и достопримечательностях этого удивительного региона.")
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button(action: {
                        //
                    }) {
                        Text("Начать путешествие")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                Rectangle()
                                    .fill(Color.green.opacity(0.5))
                            )
                            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                    }
                    .padding(.top, 24)
                }
            }
            .padding(50)
            .onAppear {
                withAnimation(.easeInOut(duration: 1)) {
                    isTextVisible = true
                }
            }
        }
    }
}

#Preview {
    GreetingView()
}

