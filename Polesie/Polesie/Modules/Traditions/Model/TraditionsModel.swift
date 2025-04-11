//
//  TraditionsModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//

import Foundation

struct TraditionsModel: Codable, Identifiable, Hashable {
    var id: Int
    let icon: String
    let title: String
    let listModels: [TraditionListModel]?
}

struct TraditionListModel:  Codable, Identifiable, Hashable {
    var id: Int
    let icons: String?
    let title: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id, icons, title, description
    }
}
