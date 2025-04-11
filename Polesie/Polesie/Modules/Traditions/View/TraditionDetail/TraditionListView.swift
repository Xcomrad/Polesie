//
//  TraditionDetailView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//

import SwiftUI

struct TraditionListView: View {
    @ObservedObject var vm: TraditionsViewModel
    @State private var selectedListItem: TraditionListModel? = nil
    
    var title: String
    var traditionList: [TraditionListModel]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Constants.Colors.background
                    .opacity(Constants.PaddingSizes.p05)
                    .ignoresSafeArea(.all)
                
                VStack {
                    headerText
                    ForEach(traditionList, id: \.id) { item in
                        TraditionListCell(traditionList: item) {
                            selectedListItem = item
                        }
                    }
                    Spacer()
                    .padding(.vertical, Constants.PaddingSizes.p05)
                }
            }
        }
        .onAppear {
            vm.fetchData()
        }
        .fullScreenCover(item: $selectedListItem) { item in
            TraditionDetailView(vm: vm,
                                title: item.title,
                                description: item.description)
        }
    }
       
    // MARK: - Components
    private var headerText: some View {
        Text(title)
            .multilineTextAlignment(.leading)
            .font(Constants.BaseFonts.h2Bold)
            .padding()
    }
}
