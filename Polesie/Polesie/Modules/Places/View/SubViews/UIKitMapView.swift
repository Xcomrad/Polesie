//
//  UIKitMapView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 24.04.25.
//

import SwiftUI
import MapKit

struct UIKitMapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D?
    @ObservedObject var vm: PlacesViewModel
    
    var selectedPlace: PlaceModel?
    var onSelectPlace: (PlaceModel) -> Void
    var isInteractionEnabled: Bool
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: UIKitMapView
        
        init(_ parent: UIKitMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard !(annotation is MKUserLocation),
                  let title = annotation.title ?? "",
                  let place = parent.vm.places.first(where: { $0.name == title }) else {
                return nil
            }
            
            let identifier = "myCustomAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = false
                annotationView?.frame = CGRect(x: 0, y: 0, width: 100, height: 120)
            } else {
                annotationView?.annotation = annotation
                annotationView?.subviews.forEach { $0.removeFromSuperview() }
            }
            
            annotationView?.isUserInteractionEnabled = true
            
            let swiftUIView = MapAnnotationView(
                imageName: place.image,
                title: place.name,
                action: { self.parent.onSelectPlace(place) }
            )
            
            let hosting = UIHostingController(rootView: swiftUIView)
            hosting.view.backgroundColor = .clear
            hosting.view.translatesAutoresizingMaskIntoConstraints = false
            hosting.view.isUserInteractionEnabled = true
            
            annotationView?.addSubview(hosting.view)
            
            NSLayoutConstraint.activate([
                hosting.view.centerXAnchor.constraint(equalTo: annotationView!.centerXAnchor),
                hosting.view.centerYAnchor.constraint(equalTo: annotationView!.centerYAnchor, constant: -40),
                hosting.view.widthAnchor.constraint(equalToConstant: 100),
                hosting.view.heightAnchor.constraint(equalToConstant: 120)
            ])
            
            return annotationView
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 52.111406, longitude: 26.102473),
            span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)
        )
        mapView.setRegion(region, animated: false)
        
        for place in vm.places {
            let annotation = MKPointAnnotation()
            annotation.title = place.name
            annotation.coordinate = place.placeCoordinates
            mapView.addAnnotation(annotation)
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let center = centerCoordinate {
            let newRegion = MKCoordinateRegion(center: center,
                                               span: MKCoordinateSpan(latitudeDelta: 0.05,
                                                                      longitudeDelta: 0.05))
            uiView.setRegion(newRegion, animated: true)
        }
        
        uiView.isUserInteractionEnabled = isInteractionEnabled
        
        // Триггер обновления отображения аннотаций
        for annotation in uiView.annotations {
            if let view = uiView.view(for: annotation) {
                view.setNeedsLayout()
            }
        }
    }
}
