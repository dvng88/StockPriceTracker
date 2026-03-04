//
//  PriceListScreen.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 04/03/2026.
//

import SwiftUI

struct PriceListScreen: View {
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(1..<30) { index in
                        StockPriceRow(
                            stock: Stock(symbol: "DEV", price: Double.random(in: 30...100), previousPrice: Double.random(in: 30...100)))
                    }
                }
            }
        }
    }
}

#Preview {
    PriceListScreen()
}
