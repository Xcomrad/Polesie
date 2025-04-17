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
    @Environment(\.isTabBarVisible) private var isTabBarVisible
    
    var body: some View {
        ZStack {
            Constants.Colors.background
                .opacity(Constants.PaddingSizes.p05)
                .ignoresSafeArea(.all)
            VStack {
                burgerButton
                MainInfo()
                Spacer()
            }
            
            if isSidebarVisible.wrappedValue {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .opacity(isSidebarVisible.wrappedValue ? 0.8 : 0)
                    .ignoresSafeArea(.all)
                    .onTapGesture {
                        animation()
                    }
                    .animation(.easeInOut(duration: Constants.PaddingSizes.p03), value: isSidebarVisible.wrappedValue)
            }
            
            if isSidebarVisible.wrappedValue {
                SidebarView(isVisible: isSidebarVisible)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
                    .offset(x: isSidebarVisible.wrappedValue ? 0 : -UIScreen.main.bounds.width)
                    .animation(.interpolatingSpring(stiffness: Constants.PaddingSizes.p300, damping: 30), value: isSidebarVisible.wrappedValue)
            }
        }
    }
    
    //MARK: - Components
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
        withAnimation(.easeInOut(duration: Constants.PaddingSizes.p05)) {
            isSidebarVisible.wrappedValue.toggle()
        }
    }
}

#Preview {
    HistoryView()
        .environment(\.isSidebarVisible, .constant(false))
}
