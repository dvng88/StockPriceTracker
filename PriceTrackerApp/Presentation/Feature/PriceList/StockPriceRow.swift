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

                PriceTextView(price: stock.price)
                    .foregroundStyle(Color.black)

                Text(stock.isPriceUp() ? "↑" : "↓")
                    .foregroundStyle(isPriceUp ? Color.green : Color.red)
                    .opacity(stock.flashState != .none ? 1 : 0)
            }
            .padding(8)
        }

    }
}

#Preview {
    StockPriceRow(
        stock: Stock.mock()
    )
}
