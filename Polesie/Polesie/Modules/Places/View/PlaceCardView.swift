//
//  PlaceCardView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 23.04.25.
//

import SwiftUI

struct PlaceCardView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let place: PlaceModel
    
    var onClose: () -> Void
    var onDetail: () -> Void
    var onNavigate: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            backgroundLayer
            
            VStack(spacing: Constants.PaddingSizes.p8) {
                content
                buttonsGroup
            }
            .padding(Constants.PaddingSizes.p24)
            
            closeButton
                .padding(Constants.PaddingSizes.p16)
        }
    }
    
    // MARK: - Components
    private var backgroundLayer: some View {
        Constants.Colors.background
            .opacity(Constants.PaddingSizes.p05)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var content: some View {
        VStack(spacing: Constants.PaddingSizes.p8) {
            Text(place.name)
                .font(Constants.BaseFonts.h2Bold)
                .foregroundStyle(Constants.Colors.text)
                .multilineTextAlignment(.center)
            
            Text(place.description)
                .font(Constants.BaseFonts.body)
                .foregroundStyle(Constants.Colors.text)
                .lineLimit(5)
                .truncationMode(.tail)
        }
        .background(
            RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                .fill(Constants.Colors.background
                    .opacity(Constants.PaddingSizes.p05))
        )
        .padding(Constants.PaddingSizes.p24)
    }
    
    private var buttonsGroup: some View {
        HStack(spacing: Constants.PaddingSizes.p8) {
            buttons(title: "Проложить маршрут", action: onNavigate)
            buttons(title: "Обзор", action: onDetail)
        }
    }
    
    private var closeButton: some View {
        Button(action: onClose) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: Constants.PaddingSizes.p35,
                       height: Constants.PaddingSizes.p35)
                .foregroundColor(Constants.Colors.accent)
        }
        .adaptiveShadow(colorScheme: colorScheme)
    }
    
    private func buttons(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(Constants.BaseFonts.small)
                .foregroundStyle(Constants.Colors.button)
                .padding(Constants.PaddingSizes.p8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                        .fill(Constants.Colors.accent)
                )
        }
    }
}
