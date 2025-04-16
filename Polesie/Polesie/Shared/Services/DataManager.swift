//
//  DataManager.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 10.04.25.
//

import Foundation

protocol DataManagerProtocol {
    func loadDataFromBundle<T: Decodable>(file: String,
                                          type: T.Type) async throws -> T
    func save<T: Encodable>(_ object: T,
                            to file: String,
                            in directory: FileManager.SearchPathDirectory) throws
    func load<T: Decodable>(from file: String,
                            in directory: FileManager.SearchPathDirectory) throws -> T
    func delete(file: String,
                in directory: FileManager.SearchPathDirectory) throws
    
    func savePassedTheme(_ id: [Int]) async throws
    func loadPassedTheme() async throws -> [Int]
    
    func saveFavoriteTraditions(_ id: [Int]) async throws
    func loadFavoriteTraditions() async throws -> [Int]?
    
    func saveFavoritePlaces(_ id: [Int]) async throws
    func loadFavoritePlaces() async throws -> [Int]?
}

final class DataManager: DataManagerProtocol {
    private let fileManager: FileManager
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
        encoder.outputFormatting = .prettyPrinted
    }
    
    // MARK: - From Bundle
    func loadDataFromBundle<T: Decodable>(file: String, type: T.Type) async throws -> T {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            throw FileError.fileNotFoundInBundle
        }
        
        let data = try Data(contentsOf: url)
        return try decoder.decode(T.self, from: data)
    }
    
    // MARK: - From Manager
    func save<T: Encodable>(_ object: T,
                            to file: String,
                            in directory: FileManager.SearchPathDirectory = .documentDirectory) throws {
        let directoryURL = try selectDirectory(directory)
        let fileURL = directoryURL.appendingPathComponent("\(file).json")
        let data = try encoder.encode(object)
        try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
    }
    
    func load<T: Decodable>(from file: String,
                            in directory: FileManager.SearchPathDirectory = .documentDirectory) throws -> T {
        let directoryURL = try selectDirectory(directory)
        let fileURL = directoryURL.appendingPathComponent("\(file).json")
        guard fileManager.fileExists(atPath: fileURL.path) else {
            throw FileError.fileNotFound
        }
        
        let data = try Data(contentsOf: fileURL)
        return try decoder.decode(T.self, from: data)
    }
    
    func delete(file: String,
                in directory: FileManager.SearchPathDirectory = .documentDirectory) throws {
        let directoryURL = try selectDirectory(directory)
        let fileURL = directoryURL.appendingPathComponent("\(file).json")
        if fileManager.fileExists(atPath: fileURL.path) {
            try fileManager.removeItem(at: fileURL)
        }
    }
    
    // MARK: - Private
    private func selectDirectory(_ directory: FileManager.SearchPathDirectory) throws -> URL {
        switch directory {
        case .documentDirectory:
            return try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        case .cachesDirectory:
            return try fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        default:
            throw FileError.invalidDirectory
        }
    }
}

// MARK: - For passed quiz themes
extension DataManager {
    private var passedThemesFile: String { "passedThemes" }
    
    func savePassedTheme(_ id: [Int]) async throws {
        try save(id, to: passedThemesFile)
    }
    
    func loadPassedTheme() async throws -> [Int] {
        try load(from: passedThemesFile)
    }
}

// MARK: - For traditions
extension DataManager {
    private var favoriteTraditions: String { "favoriteTraditions" }
    
    func saveFavoriteTraditions(_ id: [Int]) async throws {
        try save(id, to: favoriteTraditions)
    }
    
    func loadFavoriteTraditions() async throws -> [Int]? {
        try load(from: favoriteTraditions)
    }
}

// MARK: - For places
extension DataManager {
    private var favoritePlaces: String { "favoritePlaces" }
    
    func saveFavoritePlaces(_ id: [Int]) async throws {
        try save(id, to: favoritePlaces)
    }
    
    func loadFavoritePlaces() async throws -> [Int]? {
        try load(from: favoritePlaces)
    }
}
