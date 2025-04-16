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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Constants.Colors.background
                    .opacity(Constants.PaddingSizes.p05)
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
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
            .navigationTitle("Традиции")
            .navigationDestination(item: $selectedTradition) { item in
                TraditionListView(vm: vm,
                                  title: item.title,
                                  traditionList: item.listModels ?? [])
            }
        }
        .onAppear {
            Task { await vm.fetchData() }
        }
    }
}
