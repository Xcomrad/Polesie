//
//  Coordinator.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 26.04.25.
//

import MapKit
import SwiftUI

final class Coordinator: NSObject, MKMapViewDelegate {
    private let parent: MapManagerProtocol
    private let onSelectPlace: (PlaceModel) -> Void
    
    init(parent: MapManagerProtocol, onSelectPlace: @escaping (PlaceModel) -> Void) {
        self.parent = parent
        self.onSelectPlace = onSelectPlace
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let placeAnnotation = annotation as? PlaceAnnotation else {
            return nil
        }
        
        let identifier = "MapAnnotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = false
            annotationView?.frame = CGRect(x: 0, y: 0,
                                           width: Constants.PaddingSizes.p100,
                                           height: Constants.PaddingSizes.p120)
        } else {
            annotationView?.annotation = annotation
            annotationView?.subviews.forEach { $0.removeFromSuperview() }
        }
        
        annotationView?.isUserInteractionEnabled = true
        
        let swiftUIView = MapAnnotationView(
            imageName: placeAnnotation.place.image ?? "",
            title: placeAnnotation.place.name,
            action: {
                withAnimation(.easeInOut(duration: Constants.PaddingSizes.p05)) {
                    self.onSelectPlace(placeAnnotation.place)
                }
            }
        )
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        annotationView?.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.centerXAnchor.constraint(equalTo: annotationView!.centerXAnchor),
            hostingController.view.centerYAnchor.constraint(equalTo: annotationView!.centerYAnchor, constant: -40),
            hostingController.view.widthAnchor.constraint(equalToConstant: Constants.PaddingSizes.p100),
            hostingController.view.heightAnchor.constraint(equalToConstant: Constants.PaddingSizes.p120)
        ])
        
        return annotationView
    }
}

