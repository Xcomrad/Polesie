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
    @Published var selectedPlace: PlaceModel?
    
    @Published var toastMessage: String?
    @Published var toastError: ToastType = .success
    
    @Published var showCard = false
    @Published var showDetail = false
    @Published var showToast = false
    
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager()) {
        self.dataManager = dataManager
    }
    
    // MARK: - Fetch Data
    func fetchData() async {
        do {
            let placesData = try await dataManager.loadDataFromBundle(file: "places", type: [PlaceModel].self)
            self.places = placesData
        } catch {
            self.toastMessage = (error as? AppError)?.localizedDescription
            self.toastError = .failure
            self.showToast = true
        }
    }
    
    func selectPlace(_ place: PlaceModel) {
        selectedPlace = place
        showCard = true
    }
    
    func closeCard() {
        selectedPlace = nil
        showCard = false
    }
}
