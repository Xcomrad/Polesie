//
//  TraditionsView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//

import SwiftUI

struct TraditionsView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var vm: TraditionsViewModel
    
    @State private var selectedTradition: TraditionsModel? = nil
    @State private var isShowing: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundLayer
                
                // MARK: - If no data
                if let toastMessage = vm.toastMessage {
                    ToastView(isShowing: $isShowing, message: toastMessage, type: vm.toastError)
                }
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: Constants.PaddingSizes.p200))]) {
                        ForEach(vm.traditions, id: \.self) { item in
                            TraditionCardView(imageName: item.icon, text: item.title) {
                                selectedTradition = item
                            }
                            .adaptiveShadow(colorScheme: colorScheme)
                        }
                    }
                    .padding(.bottom, Constants.PaddingSizes.p80)
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle(Constants.Strings.traditionsButtonTitle)
            .navigationDestination(item: $selectedTradition) { item in
                TraditionListView(vm: vm,
                                  title: item.title,
                                  traditionList: item.listModels ?? [])
            }
        }
        .onAppear {
            Task {
                AnalyticsManager.trackEvent(.traditionOpened)
                await vm.fetchData()
            }
        }
    }
    
    // MARK: - Components
    private var backgroundLayer: some View {
        Constants.Colors.background
            .opacity(Constants.PaddingSizes.p05)
            .ignoresSafeArea()
    }
}
