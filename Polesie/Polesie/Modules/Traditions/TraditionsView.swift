//
//  TraditionsView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct TraditionsView: View {
    
    var body: some View {
        ZStack {
            Constants.Colors.background.opacity(0.5).ignoresSafeArea(.all)
            VStack {
                Text("TraditionsView")
                Spacer()
            }
        }
    }
}

#Preview {
    TraditionsView()
}
