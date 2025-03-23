//
//  HistoryView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var fontSizeManager: FontSizeManager
    @Environment(\.colorScheme) var colorScheme
    @State private var isSidebarVisible = false
    
    var body: some View {
        ZStack {
            Constants.Colors.background.opacity(0.5).ignoresSafeArea(.all)
            VStack {
                // Кнопка для открытия меню
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isSidebarVisible.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundStyle(Constants.Colors.accent)
                        .padding()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Основной экран
                Text("Экран истории")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
            }
            
            if isSidebarVisible {
                Constants.Colors.background.ignoresSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isSidebarVisible.toggle()
                        }
                    }
            }
            
            // Боковое меню
            if isSidebarVisible {
                SidebarView(isVisible: $isSidebarVisible)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
                    .offset(x: isSidebarVisible ? 0 : UIScreen.main.bounds.width / 2)
            }
        }
    }
}

#Preview {
    HistoryView()
}
