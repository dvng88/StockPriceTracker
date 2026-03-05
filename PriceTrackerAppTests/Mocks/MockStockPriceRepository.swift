//
//  MockStockPriceRepository.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 05/03/2026.
//

import Combine
@testable import PriceTrackerApp

class MockStockPriceRepository: StockPriceRepositoryProtocol {
    private let stocksSubject = CurrentValueSubject<[Stock], Never>([])
    private let connectionSubject = CurrentValueSubject<Bool, Never>(false)

    var stockPublisher: AnyPublisher<[Stock], Never> {
        stocksSubject.eraseToAnyPublisher()
    }

    var connectionPublisher: AnyPublisher<Bool, Never> {
        connectionSubject.eraseToAnyPublisher()
    }

    var stockList: [StockDTO] = []

    private(set) var startCalled = false
    private(set) var stopCalled = false

    func start() {
        startCalled = true
        connectionSubject.send(true)
    }

    func stop() {
        stopCalled = true
        connectionSubject.send(false)
    }

    func sendStocks(_ stocks: [Stock]) {
        stocksSubject.send(stocks)
    }

}
