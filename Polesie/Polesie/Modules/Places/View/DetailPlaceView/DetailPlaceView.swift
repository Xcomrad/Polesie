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
        ZStack {
            Constants.Colors.background
                .ignoresSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .center, spacing: Constants.PaddingSizes.p24) {
                    
                    HStack {
                        Spacer()
                        closeButton
                    }
                    .padding(.top, Constants.PaddingSizes.p16)
                    .padding(.horizontal)
                    
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
                    .padding(.horizontal, Constants.PaddingSizes.p24)
                    
                    Spacer(minLength: Constants.PaddingSizes.p24)
                }
            }
        }
    }
    
    //MARK: - Components
    private var image: some View {
        Image(place.icon)
            .resizable()
            .frame(width: Constants.PaddingSizes.p250,
                   height: Constants.PaddingSizes.p200)
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
            Text(place.subtitle ?? "")
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

#Preview {
    DetailPlaceView(place: PlaceModel(id: 2, icon: "pinsk",
                                      name: "Пинск", subtitle: "Город над пиной",
                                      description: "Пинск — столица белорусского Полесья, город-музей под открытым небом и один из древних городов Беларуси. А еще по некоторым подсчетам второй (после Гродно) в стране по количеству достопримечательностей и сохранившихся памятников архитектуры. Это город трех религий, или как его еще называют «Полесский Иерусалим».",
                                      coordinate: CLLocationCoordinate2D(latitude: 52.111406, longitude: 26.102473)), onClose: {})
}
