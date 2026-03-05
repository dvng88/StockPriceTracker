//
//  StockPriceRow.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 04/03/2026.
//

import SwiftUI

struct StockPriceRow: View {
    let stock: Stock

    private var isPriceUp: Bool {
        stock.isPriceUp()
    }

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 8) {
                Text(stock.symbol)
                    .foregroundStyle(Color.black)

                Spacer()

                Text(String(format: "%.2f", stock.price))
                    .foregroundStyle(Color.black)

                Text(stock.isPriceUp() ? "↑" : "↓")
                    .foregroundStyle(isPriceUp ? Color.green : Color.red)
            }
            .padding(16)
            .background(isPriceUp ? Color.green.opacity(0.3) : Color.red.opacity(0.3))

            Divider()
        }

    }
}

#Preview {
    StockPriceRow(
        stock: Stock(
            symbol: "AAPL",
            name: "Apple",
            description: "Apple Company",
            price: 30,
            previousPrice: 29)
    )
}
