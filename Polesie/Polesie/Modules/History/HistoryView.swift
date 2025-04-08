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
            Constants.Colors.background
                .opacity(Constants.PaddingSizes.opasity)
                .ignoresSafeArea(.all)
            VStack {
                burgerButton
                MainInfo()
                Spacer()
            }
            
            if isSidebarVisible.wrappedValue {
                Rectangle()
                    .fill(.ultraThickMaterial.opacity(0.8))
                    .ignoresSafeArea(.all)
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
        withAnimation(.easeInOut(duration: Constants.PaddingSizes.opasity)) {
            isSidebarVisible.wrappedValue.toggle()
        }
    }
}

#Preview {
    HistoryView()
        .environment(\.isSidebarVisible, .constant(false))
}
