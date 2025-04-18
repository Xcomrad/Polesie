//
//  FileError.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 16.04.25.
//

import Foundation

enum AppError: Error, LocalizedError {
    case invalidDirectory
    case fileNotFound
    case decodingFailed
    case encodingFailed
    case loadingFailed
    case savingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidDirectory:
            return "Недопустимая папка"
        case .fileNotFound:
            return "Файл не найден"
        case .decodingFailed:
            return "Ошибка чтения файла"
        case .encodingFailed:
            return "Ошибка сохранения файла"
        case .loadingFailed:
            return "Не удалось загрузить данные."
        case .savingFailed:
            return "Не удалось сохранить данные."
        }
    }
}
