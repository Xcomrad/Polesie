//
//  DetailCell.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 25.04.25.
//

import SwiftUI

struct DetailCell: View {
    @Environment(\.colorScheme) var colorScheme
    let cellData: CollageModel
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            icon
            content
        }
    }
    
    // MARK: - Components
    private var icon: some View {
        Image(cellData.image)
            .resizable()
            .scaledToFill()
            .frame(width: Constants.PaddingSizes.p300,
                   height: Constants.PaddingSizes.p120)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                    .stroke(Constants.Colors.background, lineWidth: 3)
            )
            .overlay(
                LinearGradient(colors: [.clear, .background],
                               startPoint: .top,
                               endPoint: .bottom)
            )
            .clipShape(RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12))
            .adaptiveShadow(colorScheme: colorScheme)
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            Text(cellData.name)
                .font(Constants.BaseFonts.captionBold)
                .foregroundColor(.text)
            Text(cellData.subtitle)
                .font(Constants.BaseFonts.caption)
                .foregroundColor(.secondary)
        }
        .padding(Constants.PaddingSizes.p8)
    }
}

#Preview {
    DetailCell(cellData: CollageModel(id: 1,
                                      name: "Музей беларускага Палесся",
                                      image: "museim",
                                      subtitle: "Музей",
                                      description: "С 1996 года экспозиция размещается на двух этажах в здании бывшего иезуитского коллегиума XVII века. Постоянная экспозиция состоит из 11 залов: Белорусская живопись 60 - 80-х гг. XX в. Природа Полесья, Русская живопись XIX - нач. XX вв., Портретная живопись XVII - XIX вв., Промыслы и ремесла Полесья, История Пинщины с древних времён до кон. XIX в., Городской быт нач. XX в., Пинщина в годы ВОВ, Галерея партизанской славы. Одни из самых ярких экспонатов музея: деревянный велосипед, вислая печать князя Изяслава Ярославовича (Xl в.), вилка скандинавского типа, Одно из переизданий третьего статута ВКЛ XVII в. на польском языке, Туровский саркофаг XII в. Сейчас художественная коллекция Музея Белорусского Полесья считается второй по значимости в республике, после Национального художественного музея Республики Беларусь. В ней собраны картины, написанные такими известными русскими художниками, как Айвазовский, Шишкин, Пэн, Васнецов, Перов, Боголюбов и другие.",
                                      coordinates: Coordinates(latitude: 52.111415,
                                                               longitude: 26.103893)))
    
}
