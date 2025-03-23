//
//  HistoryView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var fontSizeManager: FontSizeManager
    
    var body: some View {
        ZStack {
            Constants.Colors.background.opacity(0.5).ignoresSafeArea(.all)
            VStack {
                Text("HistoryView")
                    .font(Constants.DynamicFonts.scaledFont(name: Constants.DynamicFonts.h1, baseSize: 32, scale: fontSizeManager.fontSizeScale))
                Text("HistoryView")
                    .font(.system(size: 10))
                Spacer()
            }
        }
    }
}

#Preview {
    HistoryView()
}
