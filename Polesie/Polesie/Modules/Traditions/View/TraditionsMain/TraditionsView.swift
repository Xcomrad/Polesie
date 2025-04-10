//
//  TraditionsView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//

import SwiftUI
import CoreData

struct TraditionsView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var vm: TraditionsViewModel
    var viewContext: NSManagedObjectContext
    
    var body: some View {
        NavigationStack {
            ZStack {
                Constants.Colors.background
                    .opacity(Constants.PaddingSizes.p05)
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
                        ForEach(vm.traditions, id: \.self) { item in
                            let icon = item.icon ?? ""
                            let title = item.title ?? ""
                            TraditionCardView(imageName: icon,
                                              text: title)
                            .adaptiveShadow(colorScheme: colorScheme)
                        }
                    }
                    .padding(.bottom, Constants.PaddingSizes.p80)
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Традиции")
        }
        .onAppear {
            vm.fetchTraditions(viewContext: viewContext)
        }
    }
}

