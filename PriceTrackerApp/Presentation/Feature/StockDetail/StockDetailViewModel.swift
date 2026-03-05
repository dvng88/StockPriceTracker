//
//  StockDetailViewModel.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation
import Combine

class StockDetailViewModel: ObservableObject {

    var stock: Stock

    init(stock: Stock) {
        self.stock = stock
    }
}
