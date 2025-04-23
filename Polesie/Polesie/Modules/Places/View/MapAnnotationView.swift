//
//  MapAnnotationView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 23.04.25.
//

import SwiftUI

struct MapAnnotationView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isSelected = false
    
    var imageName: String
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: Constants.PaddingSizes.p8) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.PaddingSizes.p80,
                           height: Constants.PaddingSizes.p80)
                    .clipShape(Circle())
                    .shadow(color: isSelected ? .white : .black,
                            radius: 12)
                    .padding(.all, Constants.PaddingSizes.p8)
                    .overlay {
                        Circle().stroke(
                            isSelected ? Constants.Colors.accent : Constants.Colors.stoneGray,
                            lineWidth: isSelected ? 4 : 2)
                    }
                arrowImage
            }
        }
    }
    
    // MARK: - Component
    private var arrowImage: some View {
        Image(systemName: isSelected ? "arrowtriangle.down.fill" : "arrowtriangle.down" )
            .foregroundStyle(isSelected ? Constants.Colors.accent : Constants.Colors.stoneGray)
    }
}

#Preview {
    MapAnnotationView(imageName: "pinsk", title: "Пинск", action: {  })
}
