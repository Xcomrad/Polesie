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
        dataManager.loadData(from: "traditions", type: [TraditionsModel].self) { result in
            switch result {
            case .success(let fetchedTraditions):
                DispatchQueue.main.async {
                    self.traditions = fetchedTraditions
                }
            case .failure: print("проблемки")
            }
        }
    }
}
