//
//  HistoryView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct HistoryView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.isSidebarVisible) private var isSidebarVisible
    @Environment(\.isTabBarVisible) private var isTabBarVisible

    @ObservedObject var vm: HistoryViewModel
    @State private var isShowing: Bool = true
    
    var body: some View {
        ZStack {
            Constants.Colors.background
                .opacity(Constants.PaddingSizes.p05)
                .ignoresSafeArea(.all)
            
            // MARK: - If no data
            if let toastMessage = vm.toastMessage {
                ToastView(isShowing: $isShowing, message: toastMessage, type: vm.toastError)
            }
            
            VStack {
                burgerButton
                
                if let selectedHistory = vm.selectedHistory {
                    HistoryInfoView(vm: vm, history: selectedHistory)
                }
                Spacer()
            }
            
            // MARK: - SideBar Content
            if isSidebarVisible.wrappedValue {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .opacity(isSidebarVisible.wrappedValue ? 0.8 : 0)
                    .ignoresSafeArea(.all)
                    .onTapGesture {
                        toggleSidebar()
                    }
                    .animation(.easeInOut(duration: Constants.PaddingSizes.p03),
                               value: isSidebarVisible.wrappedValue)
            }
            
            if isSidebarVisible.wrappedValue {
                SidebarView(isVisible: isSidebarVisible, vm: vm)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
                    .offset(x: isSidebarVisible.wrappedValue ? 0 : -UIScreen.main.bounds.width)
                    .animation(.interpolatingSpring(stiffness: Constants.PaddingSizes.p300, damping: 30),
                               value: isSidebarVisible.wrappedValue)
            }
        }
        .onAppear {
            Task { await vm.fetchData() }
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
