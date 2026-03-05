//
//  StockObserverUseCaseTests.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 06/03/2026.
//

import XCTest
@testable import PriceTrackerApp
import Combine

final class StockObserverUseCaseTests: XCTestCase {

    private var cancellables: Set<AnyCancellable>!
    var mockRepo: MockStockPriceRepository!
    var stockUseCase: StockObserverUseCaseImpI!

    override func setUp() {
        super.setUp()
        cancellables = []
        mockRepo = MockStockPriceRepository()
        stockUseCase = StockObserverUseCaseImpI(repository: mockRepo)
    }

    override func tearDown() {
        mockRepo = nil
        stockUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func testExecuteShouldEmitStocks() {
        let expectation = expectation(description: "Stocks emitted")

        stockUseCase.execute()
            .dropFirst()
            .sink { stocks in
                XCTAssertEqual(stocks.count, 1)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        mockRepo.sendStocks([Stock.mock()])

        wait(for: [expectation], timeout: 1)
    }

}
