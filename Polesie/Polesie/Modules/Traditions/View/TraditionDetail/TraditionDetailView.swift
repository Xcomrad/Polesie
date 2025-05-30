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
    
    @State private var scrollOffset: CGFloat = 0
    @State private var showContent = false
    
    var id: Int
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        ZStack(alignment: .top) {
           backgroundLayer
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    GeometryReader { geometry in
                        traditionHeaderImage
                            .offset(y: scrollOffset > 0 ? -scrollOffset / 3 : 0)
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
            Task { await vm.fetchData() }
            
        }
        .onDisappear {
            isTabBarVisible.wrappedValue = true
        }
    }
    
    // MARK: - Сomponents
    private var backgroundLayer: some View {
        Constants.Colors.background
            .opacity(Constants.PaddingSizes.p05)
            .ignoresSafeArea(.all)
    }
    
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
                .lineSpacing(Constants.PaddingSizes.p8)
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
                    Image(systemName: Constants.Images.chevronLeft)
                        .frame(width: Constants.PaddingSizes.p35,
                               height: Constants.PaddingSizes.p35)
                        .foregroundColor(Constants.Colors.accent)
                )
                .adaptiveShadow(colorScheme: colorScheme)
        }
    }
    
    private var saveButton: some View {
        Button {
            Task {
                withAnimation(.spring()) {
                    Task {
                        AnalyticsManager.trackEvent(.traditionFavorited, parameters: ["tradition_favorited": id])
                        await vm.toggleFavorite(id: id)
                    }
                }
            }
        } label: {
            Circle()
                .fill(Constants.Colors.background
                    .opacity(Constants.PaddingSizes.p05))
                .frame(width: Constants.PaddingSizes.p50,
                       height: Constants.PaddingSizes.p50)
                .overlay(
                    Image(systemName: vm.isFavorite(id: id) ? Constants.Images.heartFill : Constants.Images.heart)
                        .frame(width: Constants.PaddingSizes.p35,
                               height:  Constants.PaddingSizes.p35)
                        .foregroundColor(vm.isFavorite(id: id) ? .red : Constants.Colors.accent)
                )
                .adaptiveShadow(colorScheme: colorScheme)
        }
    }
}
