//
//  ViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.04.25.
//

import Foundation

@MainActor
final class HistoryViewModel: ObservableObject {
    @Published var history: [HistoryThemeModel] = []
    @Published var selectedHistory: HistoryThemeModel?
    @Published var error: AppError?
    
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager()) {
        self.dataManager = dataManager
        Task { await fetchData() }
    }
    
    // MARK: - FetchData
    func fetchData() async {
        do {
            let historyThems = try await dataManager.loadDataFromBundle(file: "history", type: [HistoryThemeModel].self)
            history = historyThems
            
            if selectedHistory == nil {
                selectedHistory = history.first
            }
        } catch {
            self.error = .fileNotFoundInBundle
        }
    }
}
