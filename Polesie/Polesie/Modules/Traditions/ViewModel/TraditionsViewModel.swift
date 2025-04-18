//
//  ViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//

import SwiftUI

@MainActor
final class TraditionsViewModel: ObservableObject {
    @Published var traditions: [TraditionsModel] = []
    @Published var favoriteTradition: [Int] = []
    @Published var toastMessage: String?
    @Published var error: AppError?
    @Published var toastError: ToastType = .success

    private let dataManager: DataManagerProtocol

    init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
    }

    // MARK: - FetchData
    func fetchData() async {
        do {
            let fetchedData = try await dataManager.loadDataFromBundle(file: "traditions", type: [TraditionsModel].self)
            traditions = fetchedData
        } catch {
            self.toastMessage = (error as? AppError)?.localizedDescription
            self.toastError = .failure
        }
    }

    // MARK: - Favorites Logic
    func toggleFavorite(id: Int) async {
        if favoriteTradition.contains(id) {
            favoriteTradition.removeAll { $0 == id }
        } else {
            favoriteTradition.append(id)
        }

        do {
            try await dataManager.saveFavoriteTraditions(favoriteTradition)
        } catch {
            self.toastMessage = (error as? AppError)?.localizedDescription
            self.toastError = .failure
        }
    }

    func isFavorite(id: Int) -> Bool {
        favoriteTradition.contains(id)
    }

    func loadFavorites() async {
        do {
            let saved = try await dataManager.loadFavoriteTraditions()
            favoriteTradition = saved ?? []
        } catch {
            self.toastMessage = (error as? AppError)?.localizedDescription
            self.toastError = .failure
        }
    }

    // MARK: - Получение списка по ID
    func getTraditionList(for id: Int) -> [TraditionListModel]? {
        traditions.first { $0.id == id }?.listModels
    }
}
