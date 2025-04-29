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
    @StateObject private var settingsVM = SettingsViewModel()
    
    @State private var showToast: Bool = true
    @State private var showSettings: Bool = false
    
    var body: some View {
        ZStack {
            backgroundLayer
            
            // MARK: - If no data
            if let toastMessage = vm.toastMessage {
                ToastView(isShowing: $showToast, message: toastMessage, type: vm.toastError)
            }
            
            VStack {
                HStack {
                    makeButtos(Constants.Images.sideBarImage, toggleSidebar, .sidebarOpened)
                    Spacer()
                    makeButtos(Constants.Images.settingsImage, toggleSettiongs, .settingsOpened)
                }
                
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
            Task {
                AnalyticsManager.trackEvent(.mainOpened)
                await vm.fetchData()
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(vm: settingsVM)
                .presentationDetents([.fraction(Constants.PaddingSizes.p03), .medium])
                .presentationDragIndicator(.visible)
                .preferredColorScheme(colorScheme)
        }
    }
    
    //MARK: - Components
    private var backgroundLayer: some View {
        Constants.Colors.background
            .opacity(Constants.PaddingSizes.p05)
            .ignoresSafeArea(.all)
    }
    
    private func makeButtos(_ icon: String, _ action: @escaping () -> Void, _ eventType: AnalyticsManager.AnalyticEvent) -> some View {
        Button(action: {
            AnalyticsManager.trackEvent(eventType)
            action()
        }) {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(Constants.Colors.accent)
                .padding()
        }
    }
    
    //MARK: - Actions
    private func toggleSidebar() {
        withAnimation(.easeInOut(duration: Constants.PaddingSizes.p03)) {
            isSidebarVisible.wrappedValue.toggle()
        }
    }
    
    private func toggleSettiongs() {
        showSettings.toggle()
    }
}
