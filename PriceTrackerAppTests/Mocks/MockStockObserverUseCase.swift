//
//  MockStockObserverUseCase.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 05/03/2026.
//

import Combine
@testable import PriceTrackerApp

class MockStockObserverUseCase: StockObserverUseCase {
    let stockSubject = PassthroughSubject<[Stock], Never>()
    let connectionSubject = PassthroughSubject<Bool, Never>()

    func execute() -> AnyPublisher<[Stock], Never> {
        stockSubject.eraseToAnyPublisher()
    }
    
    var connectionPublisher: AnyPublisher<Bool, Never> {
        connectionSubject.eraseToAnyPublisher()
    }
}
