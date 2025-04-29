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
    var onNavigate: (CollageModel) -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            backgroundLayer
            
            ScrollView {
                VStack(alignment: .center, spacing: Constants.PaddingSizes.p16) {
                    image
                    title
                    
                    Divider()
                        .padding(.horizontal)
                    
                    moreLayer
                    
                    Spacer(minLength: Constants.PaddingSizes.p12)
                    
                    interastingPlaces
                }
            }
            .padding(.horizontal, Constants.PaddingSizes.p24)
            .scrollIndicators(.hidden)
            
            closeButton
                .padding(.trailing, Constants.PaddingSizes.p24)
        }
        .onAppear {
            AnalyticsManager.trackEvent(.placeOpened)
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
            .frame(maxWidth: Constants.PaddingSizes.p300,
                   maxHeight: Constants.PaddingSizes.p250)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 4)
            }
            .shadow(color: .text, radius: Constants.PaddingSizes.p8)
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
            Image(systemName: Constants.Images.xMarkImageFill)
                .resizable()
                .frame(width: Constants.PaddingSizes.p35,
                       height: Constants.PaddingSizes.p35)
                .foregroundColor(Constants.Colors.accent)
                .background(Constants.Colors.background)
                .clipShape(Circle())
        }
        .adaptiveShadow(colorScheme: colorScheme)
    }
    
    private var moreLayer: some View {
        VStack(alignment: .leading, spacing: Constants.PaddingSizes.p12) {
            Text(Constants.Strings.moreDetailsTitle)
                .font(Constants.BaseFonts.h2Bold)
                .foregroundStyle(.text)
            
            Text(place.description)
                .font(Constants.BaseFonts.body)
                .foregroundStyle(.text)
        }
    }
    
    private var interastingPlaces: some View {
        VStack(alignment: .leading, spacing: Constants.PaddingSizes.p12) {
            Text(Constants.Strings.interestingPlacesTitle)
                .font(Constants.BaseFonts.h2Bold)
                .foregroundStyle(.text)
            
            VStack(spacing: Constants.PaddingSizes.p12) {
                ForEach(Array((place.collageModels ?? []).enumerated()), id: \.element.id) { index, collage in
                    
                    DetailCell(colorScheme: colorScheme,
                               cellData: collage,
                               delayIndex: index) { collage in
                        onNavigate(collage)
                    }
                }
            }
        }
    }
}
