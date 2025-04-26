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
            
            ZStack(alignment: .bottom) {
                VStack(spacing: Constants.PaddingSizes.p8) {
                    content
                }
                .background(
                    RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                        .fill(Constants.Colors.background)
                        .stroke(.accent)
                )
                .padding(Constants.PaddingSizes.p24)
                
                buttonsGroup
                    .offset(y: Constants.PaddingSizes.p12)
            }
            
            closeButton
                .padding(Constants.PaddingSizes.p16)
        }
    }
    
    // MARK: - Components
    
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
        .adaptiveShadow(colorScheme: colorScheme)
        .padding(Constants.PaddingSizes.p24)
    }
    
    private var buttonsGroup: some View {
        HStack(spacing: Constants.PaddingSizes.p12) {
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
                .background(Constants.Colors.background)
                .clipShape(Circle())
        }
        .adaptiveShadow(colorScheme: colorScheme)
    }
    
    private func buttons(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(Constants.BaseFonts.button)
                .foregroundStyle(Constants.Colors.button)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                        .fill(Constants.Colors.accent)
                        .stroke(Constants.Colors.background)
                )
        }
        .adaptiveShadow(colorScheme: colorScheme)
    }
}
