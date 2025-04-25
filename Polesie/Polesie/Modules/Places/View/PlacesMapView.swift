//
//  PlacesView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 22.04.25.
//

import SwiftUI
import MapKit

struct PlacesMapView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var vm: PlacesViewModel
    
    @State private var centerCoordinate: CLLocationCoordinate2D?
    @State private var selectedPlace: PlaceModel?
    @State private var showCard = false
    @State private var showDetail = false
    @State private var showToast = false
    
    var body: some View {
        ZStack {
            if let toastMessage = vm.toastMessage {
                ToastView(isShowing: $showToast, message: toastMessage, type: vm.toastError)
            }
                
            UIKitMapView(centerCoordinate: $centerCoordinate,
                         vm: vm,
                         onSelectPlace: { place in
                withAnimation(.easeInOut(duration: Constants.PaddingSizes.p05)) {
                    if selectedPlace?.id == place.id {
                        selectedPlace = nil
                        showCard = false
                        centerCoordinate = nil
                    } else {
                        selectedPlace = place
                        showCard = true
                        centerCoordinate = place.placeCoordinates
                    }
                }
            }, isInteractionEnabled: !showCard)
            .mapControls {
                MapCompass()
            }
            .ignoresSafeArea()
            
            
            if let place = selectedPlace, showCard {
                VStack {
                    Spacer()
                    PlaceCardView(place: place,
                                  onClose: {
                        withAnimation(.easeOut(duration: Constants.PaddingSizes.p05)) {
                            showCard = false
                            selectedPlace = nil
                        }
                    },
                                  onDetail: {
                        showDetail = true
                    },
                                  onNavigate: {
                        
                    })
                }
                .padding(.bottom, Constants.PaddingSizes.p120)
                .fullScreenCover(isPresented: $showDetail) {
                    DetailPlaceView(place: place, onClose: {
                        showDetail = false
                    })
                    .preferredColorScheme(colorScheme)
                }
            }
        }
        .onAppear {
            Task { await vm.fetchData() }
        }
    }
}


#Preview {
    PlacesMapView(vm: .init())
}
