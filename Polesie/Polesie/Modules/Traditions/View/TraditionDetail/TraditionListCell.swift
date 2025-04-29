//
//  TraditionListCell.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 11.04.25.
//

import SwiftUI

struct TraditionListCell: View {
    @Environment(\.colorScheme) var colorScheme
    var traditionList: TraditionListModel
    var onTap: (() -> Void)?
    
    var body: some View {
        Button(action: {
            onTap?()
        }) {
            HStack(spacing: Constants.PaddingSizes.p12) {
                HStack() {
                    traditionTitle
                    chevronImage
                }
                .padding(.all, Constants.PaddingSizes.p24)
                .background(Constants.Colors.background)
                .cornerRadius(Constants.PaddingSizes.p12)
                .adaptiveShadow(colorScheme: colorScheme)
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Components
    private var traditionTitle: some View {
        Text(traditionList.title)
            .font(Constants.BaseFonts.bodyBold)
            .foregroundStyle(Constants.Colors.text)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var chevronImage: some View {
        Image(systemName: Constants.Images.chevronForward)
            .resizable()
            .scaledToFill()
            .foregroundStyle(Constants.Colors.accent)
            .frame(width: Constants.PaddingSizes.p12,
                   height: Constants.PaddingSizes.p12)
            .padding(.trailing, Constants.PaddingSizes.p05)
    }
}
