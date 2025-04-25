//
//  PlaceModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 23.04.25.
//

import Foundation
import SwiftUI
import CoreLocation

struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }

struct PlaceModel: Hashable, Codable, Identifiable {
    let id: Int
    let image: String?
    let name: String
    let subtitle: String
    let description: String
    let collageModels: [CollageModel]?
    
    
    
    var coordinates: Coordinates
    var placeCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude,
                               longitude: coordinates.longitude)
    }
}

struct CollageModel: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
    let subtitle: String
    let description: String
    
    var coordinates: Coordinates
    var locationCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude,
                               longitude: coordinates.longitude)
    }
}
