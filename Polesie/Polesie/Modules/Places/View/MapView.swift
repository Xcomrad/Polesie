//
//  MapView 2.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 26.04.25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var vm: PlacesViewModel
    
    @ObservedObject var mapManager: MapManager
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if vm.showToast, let toastMessage = vm.toastMessage {
                ToastView(isShowing: $vm.showToast, message: toastMessage, type: vm.toastError)
            }
            
            UIKitMapView(mapView: mapManager.mapView)
                .ignoresSafeArea()
                .onAppear {
                    AnalyticsManager.trackEvent(.placeOpened)
                    mapManager.setupCoordinator { place in
                        vm.selectPlace(place)
                    } onSelectLocation: { location in
                        vm.selectLocation(location)
                    }
                    Task { await vm.fetchData() }
                }
            
                .onChange(of: vm.places) { _, new in
                    mapManager.addAnnotations(for: new)
                    mapManager.zoomCenter()
                }
                .onChange(of: vm.selectedPlace) { _, new in
                    if let place = new {
                        mapManager.focusCamera(on: place)
                    }
                }
            
            if vm.showCard, let place = vm.selectedPlace {
                VStack {
                    Spacer()
                    
                    PlaceCardView(
                        place: place,
                        onClose: {
                            withAnimation(.easeOut(duration: Constants.PaddingSizes.p05)) {
                                vm.closeCard()
                                mapManager.unlockCamera()
                            }
                        },
                        onDetail: {
                            AnalyticsManager.trackEvent(.annotationOverview)
                            vm.showDetail = true
                        },
                        onNavigate: {
                            AnalyticsManager.trackEvent(.navigationStarted)
                            if let userLocation = mapManager.findUserLocation(),
                               let destinationCoordinate = vm.selectedPlace?.placeCoordinates {
                                mapManager.startNavigation(from: userLocation, to: destinationCoordinate)
                            }
                        }
                    )
                    .padding(.bottom, Constants.PaddingSizes.p120)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.easeInOut(duration: Constants.PaddingSizes.p05), value: vm.showCard)
                }
                .fullScreenCover(isPresented: $vm.showDetail) {
                    DetailPlaceView(place: place, onClose: {
                        vm.showDetail = false
                    }, onNavigate: { collage in
                        if let userLocation = mapManager.findUserLocation() {
                            mapManager.startNavigation(from: userLocation, to: collage.locationCoordinates)
                        }
                    })
                    .preferredColorScheme(colorScheme)
                }
            }
            
            HStack {
                mapButtons(Constants.Images.squareArrowtriangle, mapManager.zoomCenter)
                Spacer()
                mapButtons(Constants.Images.locationSquare, mapManager.centerMapOnUser)
            }
            .padding(.horizontal, Constants.PaddingSizes.p12)
            .padding(.vertical, Constants.PaddingSizes.p100)
        }
    }
    
    
    // MARK: - Components
    private func mapButtons(_ name: String, _ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.PaddingSizes.p8)
                    .fill(Constants.Colors.background)
                    .adaptiveShadow(colorScheme: colorScheme)
                
                Image(systemName: name)
                    .font(.system(size: Constants.PaddingSizes.p24))
                    .foregroundColor(Constants.Colors.accent)
            }
            .frame(width: Constants.PaddingSizes.p35,
                   height: Constants.PaddingSizes.p35)
        }
    }
}
