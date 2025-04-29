//
//  TraditionCard.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//

import SwiftUI

struct TraditionCardView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isPressed = false
    @State private var isVisible = false
    
    let imageName: String
    let text: String
    var onTap: (() -> Void)?
    
    var body: some View {
        ZStack(alignment: .leading) {
            traditionImage
            
            VStack {
                Spacer()
                traditionText
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12))
        .padding(.all, Constants.PaddingSizes.p12)
        .padding(.top, Constants.PaddingSizes.p12)
        .opacity(isVisible ? 1 : 0)
        .animation(.spring(duration: Constants.PaddingSizes.p03), value: isVisible)
        .onAppear {
            isVisible = true
        }
        .onTapGesture {
            AnalyticsManager.trackEvent(.traditionSelected)
            onTap?()
        }
    }
    
    // MARK: - Components
    private var traditionImage: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: Constants.PaddingSizes.p200)
            .clipped()
            .overlay {
                LinearGradient(
                    colors: [.clear, Constants.Colors.background],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
    }
    
    private var traditionText: some View {
        Text(text)
            .font(Constants.BaseFonts.bodyBold)
            .foregroundStyle(Constants.Colors.text)
            .lineLimit(1)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, Constants.PaddingSizes.p16)
            .padding(.vertical, Constants.PaddingSizes.p16)
    }
}
