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
    @Environment(\.isSidebarVisible) private var isSidebarVisible
    
    var body: some View {
        ZStack {
            Constants.Colors.background.opacity(0.5).ignoresSafeArea(.all)
            VStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isSidebarVisible.wrappedValue.toggle()
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
            
            if isSidebarVisible.wrappedValue {
                Constants.Colors.background.ignoresSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isSidebarVisible.wrappedValue.toggle()
                        }
                    }
            }
            
            if isSidebarVisible.wrappedValue {
                SidebarView(isVisible: isSidebarVisible)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
                    .offset(x: isSidebarVisible.wrappedValue ? 0 : -UIScreen.main.bounds.width)
            }
        }
    }
}

#Preview {
    HistoryView()
        .environment(\.isSidebarVisible, .constant(false))
}
