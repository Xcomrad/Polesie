//
//  QuizzesView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct QuizzesView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTheme: QuizThemesModel?
    @ObservedObject var vm: QuizViewModel
    
    private let columns = 2
    
    var body: some View {
        NavigationStack {
            ZStack {
                Constants.Colors.background
                    .opacity(Constants.PaddingSizes.p05)
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    PinterestGrid(items: vm.quizThemes, columns: columns) { theme in
                        CardsView(theme: theme, selectedTheme: $selectedTheme)
                            .adaptiveShadow(colorScheme: colorScheme)
                    }
                    .padding()
                    .padding(.bottom, Constants.PaddingSizes.p80)
                }
            }
            .navigationTitle("Квизы")
            .onAppear {
                vm.fetchData()
            }
            .fullScreenCover(item: $selectedTheme) { theme in
                QuizzesCardView(vm: vm)
                    .onAppear {
                        vm.startQuize(with: theme)
                    }
            }
        }
    }
}

// MARK: - Components
struct PinterestGrid<Content: View, Item: Identifiable>: View {
    let items: [Item]
    let columns: Int
    let content: (Item) -> Content
    
    var body: some View {
        HStack(alignment: .top, spacing: Constants.PaddingSizes.p12) {
            ForEach(0..<columns, id: \.self) { column in
                LazyVStack(spacing: Constants.PaddingSizes.p12) {
                    ForEach(itemsForColumn(column)) { item in
                        content(item)
                    }
                }
            }
        }
    }
    
    private func itemsForColumn(_ column: Int) -> [Item] {
        items.enumerated()
            .filter { $0.offset % columns == column }
            .map { $0.element }
    }
}

struct CardsView: View {
    let theme: QuizThemesModel
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedTheme: QuizThemesModel?
    
    @State private var isPressed = false
    @State private var isVisible = false
    
    var body: some View {
        Button {
            selectedTheme = theme
        } label: {
            VStack(alignment: .center, spacing: Constants.PaddingSizes.p8) {
                Text(theme.name)
                    .font(Constants.BaseFonts.captionBold)
                    .foregroundStyle(Constants.Colors.text)
                
                Text(theme.description)
                    .font(Constants.BaseFonts.small)
                    .foregroundStyle(Constants.Colors.text)
                    .truncationMode(.tail)
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [Constants.Colors.background, Constants.Colors.background.opacity(Constants.PaddingSizes.p05)],
                               startPoint: .top,
                               endPoint: .bottom))
            .cornerRadius(Constants.PaddingSizes.p12)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                    .stroke(Constants.Colors.stoneGray.opacity(Constants.PaddingSizes.p05),
                            lineWidth: Constants.PaddingSizes.p05))
            .opacity(isVisible ? 1 : 0)
            .animation(.easeOut(duration: Constants.PaddingSizes.p05), value: isPressed)
            .animation(.spring(duration: Constants.PaddingSizes.p05), value: isVisible)
        }
        .onTapGesture {
            withAnimation {
                isPressed.toggle()
            }
        }
        .onAppear {
            isVisible = true
        }
        .adaptiveShadow(colorScheme: colorScheme)
        .buttonStyle(.plain)
    }
}

#Preview {
    QuizzesView(vm: QuizViewModel(dataManager: DataManager()))
}
