//
//  TraditionsModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//


import Foundation

struct TraditionsModel: Identifiable, Codable, Hashable {
    var id: Int
    let icon: String
    let title: String
}
