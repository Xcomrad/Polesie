//
//  SubthemesSection.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.04.25.
//

import SwiftUI

struct SubthemesSection: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var fontSizeManager: FontSizeManager
    
    let subthemes: [HistorySubthemeModel]
    let expandSubtheme: Set<Int>
    let onTap: ((Int) -> Void)
    
    var body: some View {
        ScrollViewReader { proxy in
            LazyVStack(alignment: .leading, spacing: Constants.PaddingSizes.p24) {
                
                if !subthemes.isEmpty {
                    ForEach(subthemes, id: \.id) { item in
                        subthemeCell(item: item, proxy: proxy)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: Constants.PaddingSizes.p16)
                                    .fill(Constants.Colors.background)
                                    .adaptiveShadow(colorScheme: colorScheme))
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func subthemeCell(item: HistorySubthemeModel, proxy: ScrollViewProxy) -> some View {
        LazyVStack(spacing: Constants.PaddingSizes.p8) {
            subthemeButton(item: item, proxy: proxy)
            
            if expandSubtheme.contains(item.id) {
                subthemeButtonContent(item: item)
                    .padding(.top, Constants.PaddingSizes.p12)
                    .id(item.id)
            }
        }
    }
    
    private func subthemeButton(item: HistorySubthemeModel, proxy: ScrollViewProxy) -> some View {
        Button {
            withAnimation(.easeInOut(duration: Constants.PaddingSizes.p05)) {
                onTap(item.id)
                proxy.scrollTo(item.id, anchor: .top)
            }
        } label: {
            HStack {
                Text(item.title)
                    .font(fontSizeManager.font(.h3Bold))
                    .foregroundStyle(Constants.Colors.text)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(Constants.Colors.earthyBrown)
                    .rotationEffect(.degrees(expandSubtheme.contains(item.id) ? 180 : 0))
            }
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: expandSubtheme)
    }
    
    private func subthemeButtonContent(item: HistorySubthemeModel) -> some View {
        LazyVStack(alignment: .leading, spacing: Constants.PaddingSizes.p8) {
            Text(item.description)
                .font(fontSizeManager.font(.secondary))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
            Text(item.content.text)
                .font(fontSizeManager.font(.body))
                .foregroundStyle(Constants.Colors.text)
                .multilineTextAlignment(.leading)
                .lineSpacing(8)
                .tracking(0.4)
                .frame(idealWidth: 320, maxWidth: 480, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
