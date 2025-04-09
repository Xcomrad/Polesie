//
//  QuizzesView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct QuizzesView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTheme: QuizThemes?
    @StateObject var vm = QuizViewModel()
    
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
                }
            }
            .navigationTitle("Квизы")
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
    let theme: QuizThemes
    @Binding var selectedTheme: QuizThemes?
    
    var body: some View {
        Button {
            selectedTheme = theme
        } label: {
            VStack {
                Text(theme.name)
                    .font(Constants.BaseFonts.captionBold)
                    .padding(.vertical, Constants.PaddingSizes.p8)
                
                Text(theme.description)
                    .font(Constants.BaseFonts.small)
                    .padding(.bottom, Constants.PaddingSizes.p8)
            }
            .padding()
            .background(Constants.Colors.background)
            .cornerRadius(Constants.PaddingSizes.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.PaddingSizes.cornerRadius)
                    .stroke(Constants.Colors.stoneGray
                        .opacity(Constants.PaddingSizes.p05),
                            lineWidth: Constants.PaddingSizes.lineWidth)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    QuizzesView(vm: QuizViewModel())
}
