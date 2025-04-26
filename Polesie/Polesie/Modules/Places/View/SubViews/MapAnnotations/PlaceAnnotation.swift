//
//  PlaceAnnotation.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 26.04.25.
//

import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    let place: PlaceModel
    
    var coordinate: CLLocationCoordinate2D {
        return place.placeCoordinates
    }
    
    var title: String? {
        return place.name
    }
    
    init(place: PlaceModel) {
        self.place = place
    }
}
