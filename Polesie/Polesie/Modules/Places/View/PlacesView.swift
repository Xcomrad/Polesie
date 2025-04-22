//
//  PlacesView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 22.04.25.
//

import SwiftUI

struct PlacesView: View {
    @ObservedObject var vm: PlacesViewModel
    
    init(vm: PlacesViewModel) {
        self.vm = vm
    }
    var body: some View {
        ZStack {
            Text("Тут что-то будет")
        }
    }
    
    // MARK: - Components
    private var backgroundLayer: some View {
        Constants.Colors.background
            .opacity(Constants.PaddingSizes.p05)
            .ignoresSafeArea(.all)
    }
}

#Preview {
    PlacesView(vm: PlacesViewModel())
}
