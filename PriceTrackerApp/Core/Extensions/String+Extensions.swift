//
//  String+Extensions.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 06/03/2026.
//

import Foundation

extension String {
    var splitSymbolPrice: (symbol: String, price: Double)? {
        let parts = self.split(separator: ":", maxSplits: 1)
        guard parts.count == 2, let price = Double(parts[1]) else { return nil }

        let symbol = String(parts[0])
        return (symbol, price)
    }
}
