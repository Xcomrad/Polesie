//
//  TraditionDetailView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 9.04.25.
//

import SwiftUI

struct TraditionDetailView: View {
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
                headerView
            }
        }
    }
    
    // MARK: - Components
    private var headerView: some View {
        Image("")
    }
    
    private var description: some View {
        Text("")
    }
}

#Preview {
    TraditionDetailView()
}
