//
//  Stock.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 04/03/2026.
//

import Foundation

// Symbol name (e.g., AAPL)
// Current price
// Price change indicator (green ↑ / red ↓)


struct Stock {
    var id: String { symbol }
    let symbol: String
    var price: Double
    var previousPrice: Double

    func isPriceUp() -> Bool {
        price > previousPrice
    }
}
