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
                        ZStack {
                            CardsView(theme: theme, selectedTheme: $selectedTheme)
                                .adaptiveShadow(colorScheme: colorScheme)
                            
                            if vm.allQuestionsDone {
                                successBage
                                    .offset(x: -8, y: -8)
                                    .transition(.scale.combined(with: .opacity))
                            }
                        }
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
                DetailQuizCardView(vm: vm)
                    .preferredColorScheme(colorScheme)
                    .onAppear {
                        vm.startQuize(with: theme)
                    }
            }
        }
    }
    
    // MARK: - Bage
    private var successBage: some View {
        ZStack {
            Circle()
                .fill(Constants.Colors.swampGreen)
                .frame(width: Constants.PaddingSizes.p24,
                       height: Constants.PaddingSizes.p24)
            
            Image(systemName: "checkmark")
                .resizable()
                .scaledToFit()
                .frame(width: Constants.PaddingSizes.p12,
                       height: Constants.PaddingSizes.p12)
                .foregroundColor(Constants.Colors.button)
                .fontWeight(.bold)
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

#Preview {
    QuizzesView(vm: QuizViewModel(dataManager: DataManager()))
}
