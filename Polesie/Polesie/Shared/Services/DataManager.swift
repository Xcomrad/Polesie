//
//  DataManager.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 10.04.25.
//

import Foundation

class DataManager {
    
    // MARK: - Load static JSON from Bundle
    func loadDataFromBundle<T: Decodable>(file: String, type: T.Type) async throws -> T {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            throw NSError(domain: "DataManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "Файл не найден в Bundle."])
        }
        
        let data = try Data(contentsOf: url)
        let decodedObject = try JSONDecoder().decode(T.self, from: data)
        return decodedObject
    }
    
    // MARK: - Save
    func save<T: Encodable>(_ object: T,
                            to fileName: String,
                            in directory: FileManager.SearchPathDirectory = .documentDirectory) async throws {
        let url = getDirectory(directory).appendingPathComponent(fileName)
        
        let data = try JSONEncoder().encode(object)
        try data.write(to: url)
    }
    
    // MARK: - Load
    func load<T: Decodable>(_ fileName: String,
                            as type: T.Type,
                            from directory: FileManager.SearchPathDirectory = .documentDirectory) async throws -> T {
        let url = getDirectory(directory).appendingPathComponent(fileName)
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            throw NSError(domain: "DataManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "Файл не найден."])
        }
        
        let data = try Data(contentsOf: url)
        let decodedObject = try JSONDecoder().decode(T.self, from: data)
        return decodedObject
    }
    
    private func getDirectory(_ directory: FileManager.SearchPathDirectory) -> URL {
        return FileManager.default.urls(for: directory, in: .userDomainMask)[0]
    }
}

// MARK: - For Quiz
extension DataManager {
    private var finishedThemsFile: String { "finishedThemsFile" }
    
    func savePassedThemes(_ themes: Set<String>) async throws {
        let array = Array(themes)
        try await save(array, to: finishedThemsFile)
    }
    
    func loadPassedThemes() async throws -> Set<String> {
        let themes: [String] = try await load(finishedThemsFile, as: [String].self)
        return Set(themes)
    }
}

// MARK: - For Traditions
extension DataManager {
    private var favoritTraditionsFile: String { "favoritTraditionsFile" }
    
    func saveFaviritesTraditions(_ traditions: Set<String>) async throws {
        let array = Array(traditions)
        try await save(array, to: favoritTraditionsFile)
    }
    
    func loadFaviritesTraditions() async throws -> Set<String> {
        let traditions: [String] = try await load(favoritTraditionsFile, as: [String].self)
        return Set(traditions)
    }
}

// MARK: - For Places
extension DataManager {
    private var favoritPlacesFile: String { "favoritPlacesFile" }
    
    func saveFaviritesPlaces(_ places: Set<String>) async throws {
        let array = Array(places)
        try await save(array, to: favoritPlacesFile)
    }
    
    func loadFaviritesPlaces() async throws -> Set<String> {
        let places: [String] = try await load(favoritPlacesFile, as: [String].self)
        return Set(places)
    }
}
