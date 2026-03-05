//
//  StockDetailViewModel.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation
import Combine

class StockDetailViewModel: ObservableObject {

    @Published var stock: Stock?

    private var cancellable = Set<AnyCancellable>()
    private let stockObserverUseCase: StockDetailObserverUseCase

    init(stockSymbol: String,
         stockObserverUseCase: StockDetailObserverUseCase) {
        self.stockObserverUseCase = stockObserverUseCase

        setupStockObserverBinding(ForSymbol: stockSymbol)
    }

    func setupStockObserverBinding(ForSymbol symbol: String) {
        stockObserverUseCase.execute(symbol: symbol)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stock in
                self?.stock = stock
            }
            .store(in: &cancellable)
    }
}
