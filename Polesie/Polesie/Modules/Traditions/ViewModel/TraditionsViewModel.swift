//
//  ViewModel.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//

import Foundation

class TraditionsViewModel: ObservableObject {
    
    var traditions: [TraditionsModel] = [
        TraditionsModel(image: "tradition1", title: "Обряды и праздники"),
        TraditionsModel(image: "tradition2", title: "Семейные традиции"),
        TraditionsModel(image: "tradition3", title: "Народные верования"),
        TraditionsModel(image: "tradition4", title: "Ремесла и быт"),
        TraditionsModel(image: "tradition5", title: "Кухня Полесья"),
    ]
}
