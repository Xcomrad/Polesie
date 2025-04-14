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
    @Environment(\.isTabBarVisible) var isTabBarVisible
    @ObservedObject var vm: TraditionsViewModel
    
    @State private var isPressed = false
    
    var title: String
    var description: String
    
    var body: some View {
        ZStack {
            Constants.Colors.background
                .opacity(Constants.PaddingSizes.p05)
                .ignoresSafeArea(.all)
            ScrollView {
                VStack(spacing: Constants.PaddingSizes.p16) {
                    traditionTitle
                        .padding(.top, Constants.PaddingSizes.p50)
                    traditionDescription
                }
                .padding()
            }
            
            closeButton
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            isTabBarVisible.wrappedValue = false
            vm.fetchData()
        }
        .onDisappear {
            isTabBarVisible.wrappedValue = true
        }
    }
    
    // MARK: - Components
    private var traditionTitle: some View {
        Text(title)
            .font(Constants.BaseFonts.h1Bold)
            .foregroundColor(Constants.Colors.text)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
    
    private var traditionDescription: some View {
        Text(description)
            .font(Constants.BaseFonts.body)
            .foregroundColor(Constants.Colors.text)
            .lineSpacing(6)
            .padding(.horizontal)
    }
    
    private var closeButton: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrowshape.backward.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Constants.Colors.accent)
                        .frame(
                            width: Constants.PaddingSizes.p24,
                            height: Constants.PaddingSizes.p24
                        )
                }
                .adaptiveShadow(colorScheme: colorScheme)
                Spacer()
            }
            .padding(.top, Constants.PaddingSizes.p12)
            .padding(.leading, Constants.PaddingSizes.p24)
            
            Spacer()
        }
    }
}
