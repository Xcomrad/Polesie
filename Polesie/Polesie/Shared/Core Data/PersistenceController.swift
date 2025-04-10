//
//  PersistenceController.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 10.04.25.
//


import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PolesieModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Ошибка загрузки хранилища: \(error)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}

extension PersistenceController {
    func preloadTraditionsIfNeeded() {
        let decoder = JSONDecoder()
        let context = container.viewContext
        let request = Traditions.fetchRequest()
        request.fetchLimit = 1

        if let count = try? context.count(for: request), count > 0 {
            return
        }
        
        guard let url = Bundle.main.url(forResource: "traditions", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? decoder.decode([TraditionsModel].self, from: data) else {
            print("Не удалось загрузить JSON")
            return
        }
        
        for item in decoded {
            let tradition = Traditions(context: context)
            tradition.icon = item.icon
            tradition.title = item.title
        }
        
        do {
            try context.save()
            print("Традиции успешно загружены в Core Data")
        } catch {
            print("Ошибка сохранения: \(error)")
        }
    }
}
