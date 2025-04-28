//
//  PlacesViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 22.04.25.
//

import Foundation
import MapKit
import Combine

@MainActor
final class PlacesViewModel: ObservableObject {
    @Published var places: [PlaceModel] = []
    @Published var selectedPlace: PlaceModel?
    @Published var selectedLocationPlace: CollageModel?
    
    @Published var toastMessage: String?
    @Published var toastError: ToastType = .success
    
    @Published var showCard = false
    @Published var showDetail = false
    @Published var showToast = false
    
    @Published var userLocalization: CLLocationCoordinate2D?
    
    private let dataManager: DataManagerProtocol
    private var localizationManager = LocationManager()
    
    init(dataManager: DataManagerProtocol = DataManager()) {
        self.dataManager = dataManager
        setupLocationBinding()
    }
    
    private func setupLocationBinding() {
        localizationManager.$userLocation
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.userLocalization = location
            }
            .store(in: &cancellables)
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
    
    func selectLocation(_ location: CollageModel) {
        selectedLocationPlace = location
    }
    
    func closeCard() {
        selectedPlace = nil
        showCard = false
    }
    
    // MARK: - Private
    private var cancellables = Set<AnyCancellable>()
}
