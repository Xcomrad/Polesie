//
//  DetailCell.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 25.04.25.
//

import SwiftUI

struct DetailCell: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showDetailDescription: Bool = false
    let cellData: CollageModel
    
    var body: some View {
        Button {
            showDetailDescription.toggle()
        } label: {
            ZStack(alignment: .bottomLeading) {
                icon
                content
            }
        }
        .fullScreenCover(isPresented: $showDetailDescription) {
            CollageDetailView(collage: cellData) {
                showDetailDescription = false
            }
        }
        .preferredColorScheme(colorScheme)
    }
    

// MARK: - Components
private var icon: some View {
    Image(cellData.image)
        .resizable()
        .scaledToFill()
        .frame(width: Constants.PaddingSizes.p300,
               height: Constants.PaddingSizes.p200)
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
