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
    
    @ObservedObject var vm: HistoryViewModel
    
    var body: some View {
        ZStack {
            Constants.Colors.background
                .opacity(Constants.PaddingSizes.p05)
                .ignoresSafeArea(.all)
            
            if let toastMessage = vm.toastMessage {
                ToastView(message: toastMessage, type: vm.toastError)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                vm.toastMessage = nil
                            }
                        }
                    }
                    .zIndex(1)
            }
            VStack {
                burgerButton
                if let selectedHistory = vm.selectedHistory {
                    MainInfo(history: selectedHistory)
                }
                Spacer()
            }
            
            if isSidebarVisible.wrappedValue {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .opacity(isSidebarVisible.wrappedValue ? 0.8 : 0)
                    .ignoresSafeArea(.all)
                    .onTapGesture {
                        toggleSidebar()
                    }
                    .animation(.easeInOut(duration: Constants.PaddingSizes.p03), value: isSidebarVisible.wrappedValue)
            }
            
            if isSidebarVisible.wrappedValue {
                SidebarView(isVisible: isSidebarVisible, vm: vm)
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
            toggleSidebar()
        }) {
            Image(systemName: "line.horizontal.3")
                .font(.title)
                .foregroundStyle(Constants.Colors.accent)
                .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //MARK: - Actions
    private func toggleSidebar() {
        withAnimation(.easeInOut(duration: Constants.PaddingSizes.p03)) {
            isSidebarVisible.wrappedValue.toggle()
        }
    }
}
