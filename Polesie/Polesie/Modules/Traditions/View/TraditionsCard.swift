//
//  TraditionCard.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//

import SwiftUI

struct TraditionCard: View {
    let imageName: String
    let text: String
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isPressed: Bool = false
    @State private var appearAnimation = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            traditionImage
            VStack {
                Spacer()
                traditionText
            }
        }
        .scaleEffect(isPressed ? 0.90 : 1)
        .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.6), value: isPressed)
        .opacity(appearAnimation ? 1 : 0)
        .offset(y: appearAnimation ? 0 : 20)
        .clipShape(RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12))
        .frame(height: Constants.PaddingSizes.p200)
        .padding(.horizontal, Constants.PaddingSizes.p24)
        .onAppear {
            withAnimation(.spring().delay(0.2)) {
                appearAnimation = true
            }
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
                LinearGradient(colors: [.clear, .clear, .background],
                               startPoint: .top, endPoint: .bottom)
            }
    }
    
    private var traditionText: some View {
        Text(text)
            .font(Constants.BaseFonts.bodyBold)
            .foregroundStyle(Constants.Colors.earthyBrown)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, Constants.PaddingSizes.p16)
            .padding(.vertical, Constants.PaddingSizes.p16)
    }
}

#Preview {
    TraditionCard(imageName: "", text: "")
}
