//
//  Stock.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 04/03/2026.
//

import Foundation

// Symbol name (e.g., AAPL)
// Name
// Description
// Current price
// Price change indicator (green ↑ / red ↓)

struct StockDTO: Decodable {
    let symbol: String
    let name: String
    let description: String
}

struct Stock: Hashable {
    var id: String { symbol }
    let symbol: String
    let name: String
    let description: String
    var price: Double = 0
    var previousPrice: Double = 0

    func isPriceUp() -> Bool {
        price > previousPrice
    }

    static func mock() -> Stock {
        Stock(
            symbol: "AAPL",
            name: "Apple Inc.",
            description: "Global technology leader known for the iPhone and high-margin services.",
            price: 30,
            previousPrice: 29)
    }
}
