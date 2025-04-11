//
//  TraditionCard.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//

import SwiftUI

struct TraditionCardView: View {
    let imageName: String
    let text: String
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isPressed = false
    @State private var isVisible = false
    
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
        .animation(.easeOut(duration: Constants.PaddingSizes.p05), value: isPressed)
        .animation(.spring(duration: Constants.PaddingSizes.p05), value: isVisible)
        .onAppear {
            isVisible = true
        }
        .gesture(
            TapGesture()
                .onEnded { _ in /* детальный экран */ }
                .simultaneously(with: LongPressGesture(minimumDuration: 0.1)
                    .onChanged { _ in isPressed = true }
                    .onEnded { _ in isPressed = false }
                )
        )
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

#Preview {
    TraditionCardView(imageName: "", text: "")
}
