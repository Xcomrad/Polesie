//
//  ViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//

import SwiftUI
import CoreData

class TraditionsViewModel: ObservableObject {
    @Published var traditions: [Traditions] = []
    
    func fetchTraditions(viewContext: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Traditions> = Traditions.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        do {
            let fetchedResults = try viewContext.fetch(fetchRequest)
            traditions = fetchedResults
            
        } catch {
            print("Ошибка получения традиций: \(error)")
        }
    }
}
