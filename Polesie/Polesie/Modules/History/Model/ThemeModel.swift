//
//  Theme.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.04.25.
//

import Foundation

struct HistoryThemeModel: Identifiable, Codable {
    let id: Int
    let title: String
    let subtitle: String
    var content: HistoryContent
    var subthemes: [HistorySubthemeModel]
}

struct HistorySubthemeModel: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    var content: HistoryContent
}

struct HistoryContent: Codable {
    var text: String
    var images: [String]
    var links: [String]
}
