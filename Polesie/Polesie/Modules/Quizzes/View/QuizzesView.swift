//
//  QuizzesView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 18.03.25.
//

import SwiftUI

struct QuizzesView: View {
    
    var body: some View {
        ZStack {
            Constants.Colors.background.opacity(0.5).ignoresSafeArea(.all)
            VStack {
                Text("QuizzesView")
                Spacer()
            }
        }
    }
}

#Preview {
    QuizzesView()
}
