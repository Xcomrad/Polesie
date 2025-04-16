//
//  FileError.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 16.04.25.
//

import Foundation

enum FileError: Error, LocalizedError {
    case invalidDirectory
    case fileNotFound
    case fileNotFoundInBundle
    case decodingFailed
    case encodingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidDirectory: return "Недопустимая папка"
        case .fileNotFound: return "Файл не найден"
        case .fileNotFoundInBundle: return "Файл не найден в бандле"
        case .decodingFailed: return "Ошибка чтения файла"
        case .encodingFailed: return "Ошибка сохранения"
        }
    }
}
