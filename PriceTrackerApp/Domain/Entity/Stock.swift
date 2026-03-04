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
    let id: UUID = UUID()
    let symbol: String
    let price: Double
    let previousPrice: Double

    func isPriceUp() -> Bool {
        price > previousPrice
    }
}
