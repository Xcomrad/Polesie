//
//  ColageDetail.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 25.04.25.
//

import SwiftUI

struct CollageDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    var collage: CollageModel
    var onClose: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            backgroundLayer
            
            ScrollView {
                VStack(spacing: Constants.PaddingSizes.p16) {
    
                    ZStack(alignment: .bottomLeading) {
                        image
                        content
                            .padding(.horizontal, Constants.PaddingSizes.p16)
                    }
                    
                    VStack(alignment: .leading, spacing: Constants.PaddingSizes.p16) {
                        Text(collage.description)
                            .font(Constants.BaseFonts.body)
                            .foregroundColor(.text)
                            .padding(.horizontal)
                        
                        Divider()
                            .padding(.horizontal)
                        
                        toNavigationButton
                    }
                }
            }
            .scrollContentBackground(.hidden)
            
            closeButton
                .padding(.trailing, Constants.PaddingSizes.p24)
        }
    }
    
    // MARK: - Components
    private var backgroundLayer: some View {
        Constants.Colors.background
            .ignoresSafeArea()
    }
    
    private var image: some View {
            Image(collage.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: UIScreen.main.bounds.width,
                       maxHeight: Constants.PaddingSizes.p300)
                .clipped()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Constants.Colors.background, .clear, Constants.Colors.background]),
                        startPoint: .top,
                        endPoint: .bottom)
                )
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
    
    private var closeButton: some View {
        Button(action: onClose) {
            Image(systemName: "xmark.circle.fill")
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
        Button {
            // to map
        } label: {
            HStack {
                Image(systemName: "mappin")
                Text("Проложить маршрут")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.accent)
            .foregroundStyle(Constants.Colors.button)
        }
    }
}
    
    #Preview {
        CollageDetailView(collage: CollageModel(id: 1,
                                                name: "Брестская крепость",
                                                image: "brestKrepost",
                                                subtitle: "Крепость - герой",
                                                description: "8 мая 1965 года Брестской крепости за её героическую оборону в июне-июле 1941 года присвоено звание «Крепость-герой» — высшая степень отличия, которой удостоены единственная крепость и двенадцать городов Советского Союза, прославившихся своей героической обороной во время Великой Отечественной войны 1941—1945 годов.",
                                                coordinates: Coordinates(latitude: 52.085202,
                                                                         longitude: 23.668053)),
                          onClose: { })
    }
