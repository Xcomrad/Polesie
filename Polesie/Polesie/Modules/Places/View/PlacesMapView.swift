//
//  PlacesView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 22.04.25.
//

import SwiftUI
import MapKit

struct PlacesMapView: View {
    @ObservedObject var vm: PlacesViewModel
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 52.111406, longitude: 26.102473),
            span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)
        )
    )
    
    @State private var selectedPlace: PlaceModel?
    @State private var showCard = false
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition, interactionModes: [.all]) {
                UserAnnotation()
                ForEach(vm.places, id: \.id) { place in
                    Annotation(place.name, coordinate: place.coordinate) {
                        MapAnnotationView(imageName: place.icon, title: place.description) {
                            
                            withAnimation(.easeInOut(duration:  Constants.PaddingSizes.p05)) {
                                cameraPosition = .camera(
                                    MapCamera(
                                        centerCoordinate: CLLocationCoordinate2D(
                                            latitude: place.coordinate.latitude - 0.005,
                                            longitude: place.coordinate.longitude
                                        ),
                                        distance: 6000,
                                        heading: 0,
                                        pitch: 45
                                    )
                                )
                            }
                            
                            withAnimation(.easeInOut(duration:  Constants.PaddingSizes.p05)) {
                                selectedPlace = place
                                    showCard = true
                            }
                        }
                    }
                }
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
            .controlSize(.large)
            .mapStyle(.hybrid)
            .ignoresSafeArea()
            
            if showCard, let selectedPlace {
                VStack() {
                    Spacer()
                    PlaceCardView(place: selectedPlace) {
                        withAnimation(.easeInOut(duration: Constants.PaddingSizes.p05)) {
                            showCard = false
                        }
                    } onDetail: {
                        // детали
                    } onNavigate: {
                        // маршрут
                    }
                }
                .padding(.bottom,  Constants.PaddingSizes.p200)
            }
        }
    }
}
