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

    private var flashColor: Color {
        flash ? (isPriceUp ? Color.green.opacity(0.3) : Color.red.opacity(0.3)) : .clear
    }

    @State private var flash: Bool = false

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 8) {
                Text(stock.symbol)
                    .foregroundStyle(Color.black)

                Spacer()

                PriceTextView(price: stock.price)
                    .foregroundStyle(Color.black)

                if flash {
                    Text(stock.isPriceUp() ? "↑" : "↓")
                        .foregroundStyle(isPriceUp ? Color.green : Color.red)
                }
            }
            .padding(16)
            .background(flashColor)
            .onChange(of: stock.price) { _, _ in
                flash = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    flash = false
                }
            }

            Divider()
        }

    }
}

#Preview {
    StockPriceRow(
        stock: Stock.mock()
    )
}
