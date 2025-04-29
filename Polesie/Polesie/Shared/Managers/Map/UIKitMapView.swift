//
//  UIKitMapView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 24.04.25.
//

import SwiftUI
import MapKit

struct UIKitMapView: UIViewRepresentable {
    var mapView: MKMapView
    
    func makeUIView(context: Context) -> MKMapView {
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
}
