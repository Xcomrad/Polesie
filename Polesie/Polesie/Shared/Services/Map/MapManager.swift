//
//  MapManager.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 26.04.25.
//

import Foundation
import MapKit
import SwiftUI

protocol MapManagerProtocol {
    var mapView: MKMapView { get }
    func setupCoordinator(onSelectPlace: @escaping (PlaceModel) -> Void,
                          onSelectLocation: @escaping (CollageModel) -> Void)
    func addAnnotations(for places: [PlaceModel])
    func startNavigation(from sourceCoordinate: CLLocationCoordinate2D, to destinationCoordinate: CLLocationCoordinate2D)
    func findUserLocation() -> CLLocationCoordinate2D?
    func focusCamera(on place: PlaceModel)
    func unlockCamera()
    func zoomCenter()
}

final class MapManager: NSObject, ObservableObject, MapManagerProtocol {
    @Published var mapView = MKMapView()
    private var coordinator: Coordinator?
    
    override init() {
        super.init()
        configureMap()
    }
    
    func setupCoordinator(onSelectPlace: @escaping (PlaceModel) -> Void,
                          onSelectLocation: @escaping (CollageModel) -> Void) {
        self.coordinator = Coordinator(parent: self,
                                       onSelectPlace: onSelectPlace,
                                       onSelectLocation: onSelectLocation)
        self.mapView.delegate = coordinator
    }
    
    private func configureMap() {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.mapType = .hybridFlyover
        mapView.showsCompass = false
        mapView.showsScale = true
        
        let startCenter = CLLocationCoordinate2D(latitude: 52.111406, longitude: 26.102473)
        let startSpan = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        let startRegion = MKCoordinateRegion(center: startCenter, span: startSpan)
        mapView.setRegion(startRegion, animated: false)
    }
    
    func addAnnotations(for places: [PlaceModel]) {
        mapView.removeAnnotations(mapView.annotations)
        
        for place in places.enumerated() {
            let annotation = PlaceAnnotation(place: place.element)
                self.mapView.addAnnotation(annotation)
        }
    }
    
    func findUserLocation() -> CLLocationCoordinate2D? {
        mapView.userLocation.location?.coordinate
    }
    
    func startNavigation(from sourceCoordinate: CLLocationCoordinate2D, to destinationCoordinate: CLLocationCoordinate2D) {
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        destinationMapItem.openInMaps(launchOptions: options)
    }
    
    // MARK: - Camera moved
    func focusCamera(on place: PlaceModel) {
        let camera = MKMapCamera()
        camera.centerCoordinate = place.placeCoordinates
        camera.altitude = 7000
        camera.pitch = 45
        camera.heading = 30
        
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isRotateEnabled = false
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseInOut]) {
            self.mapView.setCamera(camera, animated: false)
        }
    }
    
    func unlockCamera() {
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isRotateEnabled = true
    }
    
    // MARK: - Zoom
    func zoomCenter() {
        let annotations = mapView.annotations.filter { !($0 is MKUserLocation) }
        guard !annotations.isEmpty else { return }
        
        var zoomRect = MKMapRect.null
        for annotation in annotations {
            let point = MKMapPoint(annotation.coordinate)
            let rect = MKMapRect(x: point.x, y: point.y, width: 0.1, height: 0.1)
            zoomRect = zoomRect.union(rect)
        }
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseInOut]) {
            self.mapView.setVisibleMapRect(
                zoomRect,
                edgePadding: UIEdgeInsets(top: 60, left: 60, bottom: 180, right: 60),
                animated: true)
        }
    }
    
    func centerMapOnUser() {
        if let userLocation = findUserLocation() {
            let region = MKCoordinateRegion(
                center: userLocation,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05))
            
            UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseInOut]) {
                self.mapView.setRegion(region, animated: true)
            }
        } else {
            print("Не удалось получить местоположение пользователя")
        }
    }
}
