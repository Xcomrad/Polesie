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
    @State private var isShowing: Bool = true
    private let columns = 2
    
    @ObservedObject var vm: QuizViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundLayer
                
                // MARK: If no data
                if let toastMessage = vm.toastMessage {
                    ToastView(isShowing: $isShowing, message: toastMessage, type: vm.toastError)
                }
                
                ScrollView {
                    PinterestGrid(items: vm.quizThemes, columns: columns) { theme in
                        ZStack {
                            CardsView(theme: theme, selectedTheme: $selectedTheme)
                                .adaptiveShadow(colorScheme: colorScheme)
                                .onTapGesture {
                                    AnalyticsManager.trackEvent(.themeSelected, parameters: [
                                        "theme_id": theme.id,
                                        "theme_name": theme.name
                                    ])
                                }
                        }
                        .padding()
                        .padding(.bottom, Constants.PaddingSizes.p80)
                    }
                }
            }
            .onAppear {
                Task {
                    AnalyticsManager.trackEvent(.quizeOpened)
                    await vm.fetchData()
                }
            }
            
            .navigationTitle(Constants.Strings.quizzesButtonTitle)
            .fullScreenCover(item: $selectedTheme) { theme in
                DetailQuizCardView(vm: vm)
                    .preferredColorScheme(colorScheme)
                    .onAppear {
                        vm.startQuiz(with: theme)
                    }
            }
        }
    }
    
    
    // MARK: - Components
    private var backgroundLayer: some View {
        Constants.Colors.background
            .opacity(Constants.PaddingSizes.p05)
            .ignoresSafeArea(.all)
    }
    
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
}
