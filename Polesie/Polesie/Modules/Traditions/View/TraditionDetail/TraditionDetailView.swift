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
    
    @State private var isSaved = false
    @State private var scrollOffset: CGFloat = 0
    @State private var showContent = false
    
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        ZStack(alignment: .top) {
            Constants.Colors.background
                .opacity(Constants.PaddingSizes.p05)
                .ignoresSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    GeometryReader { geometry in
                        traditionHeaderImage
                            .offset(y: scrollOffset > 0 ? -scrollOffset/3 : 0)
                            .onAppear {
                                scrollOffset = geometry.frame(in: .global).minY
                            }
                    }
                    .frame(height: Constants.PaddingSizes.p300)
                    
                    contentSection
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 20)
                }
            }
            .overlay(navigationButtons, alignment: .top)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            withAnimation(.easeOut(duration: Constants.PaddingSizes.p05).delay(0.1)) {
                showContent = true
            }
            
            isTabBarVisible.wrappedValue = false
            vm.fetchData()
            
        }
        .onDisappear {
            isTabBarVisible.wrappedValue = true
        }
    }
    
    // MARK: - Сomponents
    private var traditionHeaderImage: some View {
        Image(icon)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width)
            .clipped()
            .overlay(alignment: .bottom) {
                LinearGradient(
                    colors: [.clear, Constants.Colors.background
                        .opacity(Constants.PaddingSizes.p05)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: Constants.PaddingSizes.p100)
            }
    }
    
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: Constants.PaddingSizes.p24) {
            Text(title)
                .font(Constants.BaseFonts.h1Bold)
                .foregroundColor(Constants.Colors.text)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, Constants.PaddingSizes.p24)
            
            Text(description)
                .font(Constants.BaseFonts.body)
                .foregroundColor(Constants.Colors.text)
                .lineSpacing(8)
                .padding(.horizontal)
        }
        .padding(.bottom, Constants.PaddingSizes.p50)
        .background(Constants.Colors.background)
        .adaptiveShadow(colorScheme: colorScheme)
    }
    
    private var navigationButtons: some View {
        HStack {
            backButton
            Spacer()
            saveButton
        }
        .padding(.horizontal)
        .padding(.top, Constants.PaddingSizes.p50)
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Circle()
                .fill(Constants.Colors.background
                    .opacity(Constants.PaddingSizes.p05))
                .frame(width: Constants.PaddingSizes.p50,
                       height:  Constants.PaddingSizes.p50)
                .overlay(
                    Image(systemName: "chevron.left")
                        .frame(width: Constants.PaddingSizes.p35,
                               height: Constants.PaddingSizes.p35)
                        .foregroundColor(Constants.Colors.accent)
                )
                .adaptiveShadow(colorScheme: colorScheme)
        }
    }
    
    private var saveButton: some View {
        Button {
            withAnimation(.spring()) {
                isSaved.toggle()
            }
        } label: {
            Circle()
                .fill(Constants.Colors.background
                    .opacity(Constants.PaddingSizes.p05))
                .frame(width: Constants.PaddingSizes.p50,
                       height: Constants.PaddingSizes.p50)
                .overlay(
                    Image(systemName: isSaved ? "heart.fill" : "heart")
                        .frame(width: Constants.PaddingSizes.p35,
                               height:  Constants.PaddingSizes.p35)
                        .foregroundColor(isSaved ? .red : Constants.Colors.accent)
                )
                .adaptiveShadow(colorScheme: colorScheme)
        }
    }
}
