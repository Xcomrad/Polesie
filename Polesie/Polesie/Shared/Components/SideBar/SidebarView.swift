//
//  SidebarView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 23.03.25.
//

import SwiftUI

struct SidebarView: View {
    private let sidebarWidh = UIScreen.main.bounds.width * 0.4
    @Environment(\.colorScheme) var colorScheme
    @Binding var isVisible: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: Constants.PaddingSizes.middlePadding) {
                clouseButton
                themeTitle
                scrollView
                Spacer()
            }
            .frame(width: sidebarWidh)
            .background(Constants.Colors.background.opacity(0.5))
        }
        .adaptiveShadow(colorScheme: colorScheme)
        .frame(width: sidebarWidh)
        .offset(x: isVisible ? -UIScreen.main.bounds.width * 0.3 : -UIScreen.main.bounds.width)
    }
    
    //MARK: - Components
    
    private var clouseButton: some View {
        Button(action: toggleSidebar) {
            Image(systemName: "xmark")
                .font(.title)
                .foregroundStyle(Constants.Colors.accent)
                .padding()
        }
    }
    
    private var themeTitle: some View {
        Text("Темы")
            .font(Constants.BaseFonts.h2Bold)
            .foregroundStyle(Constants.Colors.text)
            .padding(.horizontal)
    }
    
    private var scrollView: some View {
        ScrollView {
            LazyVStack(spacing: Constants.PaddingSizes.cornerRadius) {
                ForEach(["История", "События", "Люди", "Ремесло", "Места", "Природа"], id: \.self) { topic in
                    SidebarButton(title: topic, action: {
                        print("Выбрана тема: \(topic)")
                        toggleSidebar()
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(Constants.PaddingSizes.smalPadding)
        }
        .scrollDisabled(true)
    }
    
    //MARK: - Actions
    private func toggleSidebar() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isVisible.toggle()
        }
    }
}
