//
//  PlaceModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 23.04.25.
//

import Foundation
import CoreLocation

struct PlaceModel: Identifiable {
    let id: Int
    let icon: String
    let name: String
    let subtitle: String?
    let description: String
    let coordinate: CLLocationCoordinate2D
}
