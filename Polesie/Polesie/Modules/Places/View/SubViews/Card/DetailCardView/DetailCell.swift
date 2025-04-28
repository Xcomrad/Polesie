//
//  DetailCell.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 25.04.25.
//

import SwiftUI

struct DetailCell: View {
    @State private var showDetailDescription = false
    @State private var animate = false
   
    var colorScheme: ColorScheme
    let cellData: CollageModel
    let delayIndex: Int
    var onNavigate: (CollageModel) -> Void
    
    var body: some View {
        Button {
            showDetailDescription.toggle()
        } label: {
            ZStack(alignment: .bottomLeading) {
                icon
                content
            }
            .opacity(animate ? 1 : 0)
            .scaleEffect(animate ? 1 : 0.9)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: Constants.PaddingSizes.p05)
                    .delay(Double(delayIndex) * Constants.PaddingSizes.p05))
                {
                    animate = true
                }
            }
        }
        .fullScreenCover(isPresented: $showDetailDescription) {
            CollageDetailView(colorScheme: colorScheme, collage: cellData) {
                showDetailDescription = false
            } toMap: {
                onNavigate(cellData)
            }
        }
    }
    
    
    // MARK: - Components
    private var icon: some View {
        Image(cellData.images.first ?? "")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .aspectRatio(1.5, contentMode: .fit)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                    .stroke(Constants.Colors.background, lineWidth: 3)
            )
            .overlay(
                LinearGradient(colors: [.clear, .background],
                               startPoint: .top,
                               endPoint: .bottom)
            )
            .clipShape(RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12))
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            Text(cellData.name)
                .font(Constants.BaseFonts.captionBold)
                .foregroundColor(.text)
            Text(cellData.subtitle)
                .font(Constants.BaseFonts.caption)
                .foregroundColor(.secondary)
        }
        .padding(Constants.PaddingSizes.p8)
    }
}
