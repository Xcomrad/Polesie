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
        fetchData()
    }
    
    // MARK: - FetchData
    func fetchData() {
        dataManager.loadData(from: "traditions", type: [TraditionsModel].self) { result in
            switch result {
            case .success(let fetchedTraditions):
                DispatchQueue.main.async {
                    self.traditions = fetchedTraditions
                }
            case .failure(let failure):
                print("load traditions data error: \(failure)")
            }
        }
    }
    
    func getTraditionList(for id: Int) -> [TraditionListModel]? {
        traditions.first { $0.id == id }?.listModels
    }
}
