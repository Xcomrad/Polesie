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
    
    @ObservedObject var vm: HistoryViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: Constants.PaddingSizes.p16) {
                clouseButton
                themeTitle
                scrollView
                Spacer()
            }
            .frame(width: sidebarWidh)
            .background(Constants.Colors.background)
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
            LazyVStack(alignment: .leading, spacing: Constants.PaddingSizes.p12) {
                ForEach(vm.history) { theme in
                    SidebarButton(
                        title: theme.title,
                        isSelected: theme.id == vm.selectedHistory?.id) {
                        vm.selectedHistory = theme
                        toggleSidebar()
                    }
                }
            }
            .padding(Constants.PaddingSizes.p8)
        }
        .scrollDisabled(true)
    }
    
    //MARK: - Actions
    private func toggleSidebar() {
        withAnimation(.easeInOut(duration: Constants.PaddingSizes.p03)) {
            isVisible.toggle()
        }
    }
}
