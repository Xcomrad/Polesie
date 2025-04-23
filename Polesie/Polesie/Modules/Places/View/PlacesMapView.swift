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
            span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)))
    
    @State private var selectedPlace: PlaceModel?
    @State private var showCard = false
    @State private var visibleRegion: MKCoordinateRegion?
    
    init(vm: PlacesViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition) {
                UserAnnotation()
                ForEach(vm.places, id: \.id) { place in
                    Annotation(place.name, coordinate: place.coordinate) {
                        MapAnnotationView(imageName: place.icon,
                                          title: place.description) {
                            selectedPlace = place
                            showCard = true
                        }
                    }
                }
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
        }
    }
}

#Preview {
    PlacesMapView(vm: PlacesViewModel())
}
