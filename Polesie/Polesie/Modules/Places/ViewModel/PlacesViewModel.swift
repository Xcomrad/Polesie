//
//  PlacesViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 22.04.25.
//

import Foundation
import MapKit

@MainActor
final class PlacesViewModel: ObservableObject {
    @Published var places: [PlaceModel] = []
    @Published var toastMessage: String?
    @Published var toastError: ToastType = .success
    
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager()) {
        self.dataManager = dataManager
    }
    
    // MARK: - Fetch Data
    func fetchData() async {
        do {
            let placesData = try await dataManager.loadDataFromBundle(file: "places", type: [PlaceModel].self)
            places = placesData
            print(placesData)
        } catch {
            self.toastMessage = (error as? AppError)?.localizedDescription
            self.toastError = .failure
        }
    }
}
