//
//  TraditionsView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//


//
//  TraditionsView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct TraditionsView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var vm = TraditionsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Constants.Colors.background
                    .opacity(Constants.PaddingSizes.p05)
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
                        ForEach(vm.traditions, id: \.self) { item in
                            TraditionCardView(imageName: item.image,
                                          text: item.title)
                            .adaptiveShadow(colorScheme: colorScheme)
                        }
                    }
                              .padding(.bottom, Constants.PaddingSizes.p80)
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Традиции")
        }
    }
}

#Preview {
    TraditionsView()
}
