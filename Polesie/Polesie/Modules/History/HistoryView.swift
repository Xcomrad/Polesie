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
                burgerButton
                mainInfo
                Spacer()
            }
            
            if isSidebarVisible.wrappedValue {
                Constants.Colors.background.ignoresSafeArea(.all)
                    .onTapGesture {
                        animation()
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
    
    //MARK: - Components
    private var mainInfo: some View {
        Text("Экран истории")
            .font(.largeTitle)
            .padding()
    }
    
    private var burgerButton: some View {
        Button(action: {
            animation()
        }) {
            Image(systemName: "line.horizontal.3")
                .font(.title)
                .foregroundStyle(Constants.Colors.accent)
                .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //MARK: - Actions
    private func animation() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isSidebarVisible.wrappedValue.toggle()
        }
    }
}

#Preview {
    HistoryView()
        .environment(\.isSidebarVisible, .constant(false))
}
