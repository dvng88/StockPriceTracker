//
//  MockStockDetailObserverUseCase.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 05/03/2026.
//

@testable import PriceTrackerApp
import Combine

class MockStockDetailObserverUseCase: StockDetailObserverUseCase {
    let stockSubject = PassthroughSubject<Stock?, Never>()

    func execute(symbol: String) -> AnyPublisher<Stock?, Never> {
        stockSubject.eraseToAnyPublisher()
    }
}
