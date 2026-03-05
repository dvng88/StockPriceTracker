//
//  StockDetailViewModelTests.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 06/03/2026.
//

import XCTest
@testable import PriceTrackerApp
import Combine

final class StockDetailViewModelTests: XCTestCase {

    var viewModel: StockDetailViewModel!
    var repo: MockStockPriceRepository!
    var cancellables: Set<AnyCancellable>!

    var symbol: String = "AAPL"

    override func setUp() {
        super.setUp()
        cancellables = []
        repo = MockStockPriceRepository()
        viewModel = StockDetailViewModel(
            stockSymbol: symbol,
            stockObserverUseCase: StockDetailObserverUseCaseImpl(repository: repo)
        )

    }

    override func tearDown() {
        repo = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testGetFilteredStock() {

        let expectation = expectation(description: "Stock Filtered")

        viewModel.$stock
            .compactMap { $0 }
            .sink { [weak self] stock in
                print("Stock : \(stock)")
                XCTAssertEqual(stock.symbol, self?.symbol)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        repo.sendStocks([Stock(symbol: symbol, name: "Apple Inc", description: "Apple Company")])

        wait(for: [expectation], timeout: 3)
    }


}
