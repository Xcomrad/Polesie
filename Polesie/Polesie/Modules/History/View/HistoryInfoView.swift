//
//  MainInfo.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 8.04.25.
//

import SwiftUI

struct HistoryInfoView: View {
    @EnvironmentObject var fontSizeManager: FontSizeManager
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var vm: HistoryViewModel
    var history: HistoryThemeModel
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: Constants.PaddingSizes.p24) {
                    LazyVStack(alignment: .center, spacing: Constants.PaddingSizes.p16) {
                        headerTitile
                        divider
                        secondaryTitle
                            .padding(.horizontal, Constants.PaddingSizes.p24)
                        
                        descriptionSection
                            .padding(.top, Constants.PaddingSizes.p12)
                        
                        SubthemesSection(subthemes: history.subthemes,
                                         expandSubtheme: vm.expandSubtheme,
                                         onTap: { id in
                            vm.toggleToExpand(id)
                        })
                        .padding(.top, Constants.PaddingSizes.p24)
                    }
                    .padding(.horizontal, Constants.PaddingSizes.p16)
                    .padding(.bottom, Constants.PaddingSizes.p80)
                    .id("top")
                }
            }
            .scrollIndicators(.hidden)
            .onChange(of: history.id) { old, new in
                withAnimation {
                    proxy.scrollTo("top", anchor: .top)
                }
            }
        }
    }
    
    // MARK: - Components
    var headerTitile: some View {
        Text(history.title)
            .font(fontSizeManager.font(.h1Bold))
            .foregroundStyle(Constants.Colors.text)
            .tracking(1.2)
            .lineSpacing(4)
            .multilineTextAlignment(.center)
            .adaptiveShadow(colorScheme: colorScheme)
    }
    
    var divider: some View {
        Divider()
            .background(Constants.Colors.accent
                .opacity(Constants.PaddingSizes.p05))
    }
    
    var secondaryTitle: some View {
        Text(history.subtitle)
            .font(fontSizeManager.font(.secondary))
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
        
    }
    
    var descriptionSection: some View {
        VStack(alignment: .leading, spacing: Constants.PaddingSizes.p8) {
            if !history.content.text.isEmpty {
                Text(history.content.text)
                    .font(fontSizeManager.font(.body))
                    .foregroundStyle(Constants.Colors.text)
                    .lineSpacing(8)
                    .tracking(0.4)
                    .frame(idealWidth: 320, maxWidth: 480, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
