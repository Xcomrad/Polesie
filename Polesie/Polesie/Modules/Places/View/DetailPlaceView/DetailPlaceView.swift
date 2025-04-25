//
//  DetailPlaceView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 24.04.25.
//

import SwiftUI
import MapKit

struct DetailPlaceView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var place: PlaceModel
    var onClose: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            backgroundLayer
          
            ScrollView {
                VStack(alignment: .center, spacing: Constants.PaddingSizes.p16) {
                    image
                    title
                    
                    Divider()
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: Constants.PaddingSizes.p12) {
                        Text("Подробнее:")
                            .font(Constants.BaseFonts.h2Bold)
                            .foregroundStyle(.text)
                        
                        Text(place.description)
                            .font(Constants.BaseFonts.body)
                            .foregroundStyle(.text)
                    }
                    
                    Spacer(minLength: Constants.PaddingSizes.p12)
                    
                    VStack(alignment: .leading, spacing: Constants.PaddingSizes.p12) {
                        Text("Интересные места:")
                            .font(Constants.BaseFonts.h2Bold)
                            .foregroundStyle(.text)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: Constants.PaddingSizes.p12) {
                                ForEach(place.collageModels ?? [], id: (\.id)) { collage in
                                    DetailCell(cellData: collage)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                }
            }
            .padding(.horizontal, Constants.PaddingSizes.p24)
            .scrollIndicators(.hidden)
            
            closeButton
                .padding(.trailing, Constants.PaddingSizes.p24)
        }
    }
    
    //MARK: - Components
    private var backgroundLayer: some View {
        Constants.Colors.background
            .ignoresSafeArea(.all)
    }
    
    private var image: some View {
        Image(place.image ?? "")
            .resizable()
            .frame(width: Constants.PaddingSizes.p300,
                   height: Constants.PaddingSizes.p250)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 4)
            }
            .shadow(color: .text, radius: 7)
    }
    
    private var title: some View {
        VStack(alignment: .leading) {
            Text(place.name)
                .font(Constants.BaseFonts.h1Bold)
                .foregroundStyle(.text)
            Text(place.subtitle)
                .font(Constants.BaseFonts.small)
                .foregroundStyle(.secondary)
            
        }
    }
    
    private var closeButton: some View {
        Button(action: onClose) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: Constants.PaddingSizes.p35,
                       height: Constants.PaddingSizes.p35)
                .foregroundColor(Constants.Colors.accent)
                .background(Constants.Colors.background)
                .clipShape(Circle())
        }
        .adaptiveShadow(colorScheme: colorScheme)
    }
}
