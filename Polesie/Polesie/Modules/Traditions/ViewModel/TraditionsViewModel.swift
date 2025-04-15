//
//  ViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//

import SwiftUI


final class TraditionsViewModel: ObservableObject {
    @Published var traditions: [TraditionsModel] = []
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    // MARK: - FetchData
    func fetchData() {
        Task { @MainActor in
            do {
                let fetchedTraditions: [TraditionsModel] = try await self.dataManager.loadDataFromBundle(file: "traditions", type: [TraditionsModel].self)
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.traditions = fetchedTraditions
                }
            } catch {
                print("Ошибка при загрузке данных традиций: \(error)")
            }
        }
    }
    
    
    func getTraditionList(for id: Int) -> [TraditionListModel]? {
        traditions.first { $0.id == id }?.listModels
    }
}
