//
//  StockDetailObserverUseCaseTests.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 06/03/2026.
//

import XCTest
@testable import PriceTrackerApp
import Combine

final class StockDetailObserverUseCaseTests: XCTestCase {

    var repo: MockStockPriceRepository!
    var useCase: StockDetailObserverUseCaseImpl!
    var cancellables: Set<AnyCancellable>!


    override func setUp() {
        super.setUp()
        cancellables = []
        repo = MockStockPriceRepository()
        useCase = StockDetailObserverUseCaseImpl(repository: repo)
    }

    override func tearDown() {
        repo = nil
        useCase = nil
        cancellables = nil
        super.tearDown()
    }

    func testExecuteFiltersBySymbol() {
        let expectation = expectation(description: "Filtered stock")

        useCase.execute(symbol: "AAPL")
            .dropFirst()
            .sink { stock in
                XCTAssertEqual(stock?.symbol, "AAPL")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        repo.sendStocks([
            Stock(symbol: "AAPL", name: "Apple Inc", description: "Apple Company")
        ])

        wait(for: [expectation], timeout: 1)
    }
}
