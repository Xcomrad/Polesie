//
//  SidebarView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 23.03.25.
//

import SwiftUI

struct SidebarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isVisible: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: Constants.PaddingSizes.middlePadding) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isVisible.toggle()
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundStyle(Constants.Colors.accent)
                        .padding()
                }
                
                Text("Темы")
                    .font(Constants.BaseFonts.h2Bold)
                    .foregroundStyle(Constants.Colors.text)
                    .padding(.horizontal)
                
                // Список тем
                ScrollView {
                    VStack(spacing: Constants.PaddingSizes.cornerRadius) {
                        ForEach(["История", "События", "Люди", "Ремесло", "Места", "Природа"], id: \.self) { topic in
                            SidebarButton(title: topic, action: {
                                print("Выбрана тема: \(topic)")
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isVisible.toggle()
                                }
                            })
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(Constants.PaddingSizes.smalPadding)
                }
                .scrollDisabled(true)
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width * 0.4) // Ширина меню 40%
            .background(Constants.Colors.background.opacity(0.5))
        }
        .adaptiveShadow(colorScheme: colorScheme)
        .frame(width: UIScreen.main.bounds.width * 0.4) // Ширина меню 40%
        .offset(x: isVisible ? -UIScreen.main.bounds.width * 0.3 : -UIScreen.main.bounds.width) 
    }
}
