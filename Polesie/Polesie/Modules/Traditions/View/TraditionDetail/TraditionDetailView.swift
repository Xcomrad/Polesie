//
//  TraditionItemView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 11.04.25.
//

import SwiftUI

struct TraditionDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: TraditionsViewModel
    
    @State private var isPressed = false
    @State private var scrollToTop: Bool = false
    
    var title: String
    var description: String
    
    var body: some View {
        ScrollViewReader { proxy in
            ZStack {
                Constants.Colors.background
                    .opacity(Constants.PaddingSizes.p05)
                    .ignoresSafeArea(.all)
            ScrollView {
               
                    VStack(spacing: Constants.PaddingSizes.p16) {
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.app.fill")
                                .resizable()
                                .scaledToFill()
                                .foregroundStyle(Constants.Colors.accent)
                                .frame(width: Constants.PaddingSizes.p24,
                                       height: Constants.PaddingSizes.p24)
                        }
                        .adaptiveShadow(colorScheme: colorScheme)
                        .padding(.top, Constants.PaddingSizes.p8)
                        .padding(.leading, Constants.PaddingSizes.p8)
                        
                        traditionTitle
                        traditionDescription
                       
                        Button(action: {
                            withAnimation {
                                proxy.scrollTo("top", anchor: .top)
                            }
                        }) {
                            Image(systemName: "arrowshape.up.fill")
                                .resizable()
                                .scaledToFill()
                                .foregroundStyle(Constants.Colors.accent)
                                .frame(width: Constants.PaddingSizes.p24,
                                       height: Constants.PaddingSizes.p24)
                        }
                        .adaptiveShadow(colorScheme: colorScheme)
                        .padding(.bottom, Constants.PaddingSizes.p8)
                        .padding(.trailing, Constants.PaddingSizes.p8)
                    }
                    .padding()
                    .id("top")
                }
            }
        }
        .onAppear {
            vm.fetchData()
        }
    }
    
    // MARK: - Components
    private var traditionTitle: some View {
        Text(title)
            .font(Constants.BaseFonts.h1Bold)
            .foregroundColor(Constants.Colors.text)
            .padding(.horizontal)
    }
    
    private var traditionDescription: some View {
        Text(description)
            .font(Constants.BaseFonts.body)
            .foregroundColor(Constants.Colors.text)
            .lineSpacing(6)
            .padding(.horizontal)
    }
}

