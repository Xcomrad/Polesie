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
    let onTap: (Int) -> Void
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack(alignment: .leading, spacing: Constants.PaddingSizes.p24) {
                
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
            .animation(.spring(response: Constants.PaddingSizes.p05, dampingFraction: 0.8), value: expandSubtheme)
        }
    }
    
    @ViewBuilder
    private func subthemeCell(item: HistorySubthemeModel, proxy: ScrollViewProxy) -> some View {
        VStack(spacing: Constants.PaddingSizes.p8) {
            Color.clear
                .frame(height: 1)
                .id("anchor_\(item.id)")
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
            let isExpanded = expandSubtheme.contains(item.id)
            withAnimation(.easeInOut(duration: Constants.PaddingSizes.p05)) {
                onTap(item.id)
                
                if isExpanded {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Constants.PaddingSizes.p03) {
                        withAnimation(.spring(response: Constants.PaddingSizes.p05, dampingFraction: 0.8)) {
                            proxy.scrollTo(item.id, anchor: .top)
                        }
                    }
                    
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Constants.PaddingSizes.p03) {
                        withAnimation(.spring(response: Constants.PaddingSizes.p05, dampingFraction: 0.8)) {
                            proxy.scrollTo("anchor_\(item.id)", anchor: .top)
                        }
                    }
                }
            }
        } label: {
            HStack {
                Text(item.title)
                    .font(fontSizeManager.font(.h3Bold))
                    .foregroundStyle(Constants.Colors.text)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(Constants.Colors.accent)
                    .rotationEffect(.degrees(expandSubtheme.contains(item.id) ? 180 : 0))
            }
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: expandSubtheme)
    }
    
    private func subthemeButtonContent(item: HistorySubthemeModel) -> some View {
        VStack(alignment: .leading, spacing: Constants.PaddingSizes.p8) {
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
