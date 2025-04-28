//
//  ColageDetail.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 25.04.25.
//

import SwiftUI

struct CollageDetailView: View {
    var colorScheme: ColorScheme
    var collage: CollageModel
    var onClose: () -> Void
    var toMap: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            backgroundLayer
            
            ScrollView {
                VStack(spacing: Constants.PaddingSizes.p16) {
                    
                    images
                    content
                        .padding(.horizontal, Constants.PaddingSizes.p16)
                    
                    VStack(alignment: .leading, spacing: Constants.PaddingSizes.p16) {
                        Text(collage.description)
                            .font(Constants.BaseFonts.body)
                            .foregroundColor(.text)
                            .padding(.horizontal)
                        
                        contacsContainer
                            .padding(.horizontal)
                        
                        Divider()
                            .padding(.horizontal)
                        
                        toNavigationButton
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .preferredColorScheme(colorScheme)
            
            closeButton
                .padding(.trailing, Constants.PaddingSizes.p24)
        }
    }
    
    // MARK: - Components
    private var backgroundLayer: some View {
        Constants.Colors.background
            .ignoresSafeArea()
    }
    
    private var images: some View {
        TabView {
            ForEach(collage.images, id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity,
                           maxHeight: Constants.PaddingSizes.p300)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Constants.Colors.background, .clear, Constants.Colors.background]),
                            startPoint: .top,
                            endPoint: .bottom)
                    )
            }
        }
        .tabViewStyle(.page)
        .frame(height: Constants.PaddingSizes.p300)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(collage.name)
                .font(Constants.BaseFonts.h1Bold)
                .foregroundStyle(.text)
            Text(collage.subtitle)
                .font(Constants.BaseFonts.small)
                .foregroundStyle(.text)
        }
        .shadow(radius: Constants.PaddingSizes.p8)
    }
    
    private var contacsContainer: some View {
        VStack {
            if let website = collage.website,
                let url = URL(string: website) {
                Link(destination: url) {
                    Text("Переход на сайт: \(website)")
                        .font(Constants.BaseFonts.small)
                        .foregroundStyle(.secondary)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: Constants.PaddingSizes.p8)
                                .stroke(Constants.Colors.accent, lineWidth: 1))
                }
            }
        }
    }

    private var closeButton: some View {
        Button(action: onClose) {
            Image(systemName: Constants.Images.xMarkImageFill)
                .resizable()
                .frame(width: Constants.PaddingSizes.p35,
                       height: Constants.PaddingSizes.p35)
                .foregroundColor(Constants.Colors.accent)
                .background(Constants.Colors.background)
                .clipShape(Circle())
        }
        .adaptiveShadow(colorScheme: colorScheme)
    }
    
    private var toNavigationButton: some View {
        Button(action: toMap) {
            HStack {
                Image(systemName: Constants.Images.mapPinImage)
                Text(Constants.Strings.navigateButtonTitle)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.accent)
            .foregroundStyle(Constants.Colors.button)
        }
    }
}
