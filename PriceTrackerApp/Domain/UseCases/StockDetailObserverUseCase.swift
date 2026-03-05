//
//  StockDetailObserverUseCase.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation
import Combine

protocol StockDetailObserverUseCase {
    func execute(symbol: String) -> AnyPublisher<Stock?, Never>
}

class StockDetailObserverUseCaseImpl: StockDetailObserverUseCase {
    private let repository: StockPriceRepositoryProtocol

    init(repository: StockPriceRepositoryProtocol) {
        self.repository = repository
    }

    func execute(symbol: String) -> AnyPublisher<Stock?, Never> {
        repository.stockPublisher
            .map { stocks in
                stocks.first(where: { $0.symbol == symbol })
            }
            .eraseToAnyPublisher()
    }
}
