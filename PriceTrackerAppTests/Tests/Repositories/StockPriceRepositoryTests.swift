//
//  StockPriceRepositoryTests.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 06/03/2026.
//

import XCTest
@testable import PriceTrackerApp
import Combine

final class StockPriceRepositoryTests: XCTestCase {

    private var repository: StockPriceRepository!
    private var mockWebSocket: MockWebSocketService!
    private var mockEngine: MockPriceStreamingEngine!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()

        cancellables = []

        mockWebSocket = MockWebSocketService()
        mockEngine = MockPriceStreamingEngine()

        repository = StockPriceRepository(
            webSocket: mockWebSocket,
            streamingEngine: mockEngine
        )
    }

    override func tearDown() {
        repository = nil
        mockWebSocket = nil
        mockEngine = nil
        cancellables = nil
        super.tearDown()
    }

    func testStartShouldConnectWebSocketAndStartStreaming() {

        repository.start()

        XCTAssertTrue(mockWebSocket.connectCalled)
        XCTAssertTrue(mockEngine.startCalled)
    }

    func testStopShouldDisconnectWebSocketAndStopStreaming() {

        repository.stop()

        XCTAssertTrue(mockWebSocket.disconnectCalled)
        XCTAssertTrue(mockEngine.stopCalled)
    }

    func testWebSocketMessageUpdatesStockPrice() {

        let expectation = XCTestExpectation(description: "Stock updated")

        repository.stockPublisher
            .dropFirst()
            .sink { stocks in

                if let apple = stocks.first(where: { $0.symbol == "AAPL" }) {
                    XCTAssertEqual(apple.price, 250)
                    expectation.fulfill()
                }

            }
            .store(in: &cancellables)

        mockWebSocket.send(symbol: "AAPL", price: 250)

        wait(for: [expectation], timeout: 2)
    }

    func testStockSortingByHighestPriceFirst() {

        let expectation = XCTestExpectation(description: "Stocks sorted")

        repository.stockPublisher
            .dropFirst()
            .sink { stocks in
                print("Stocks : \(stocks)")
                XCTAssertTrue(stocks.first!.price >= stocks.last!.price)
                expectation.fulfill()

            }
            .store(in: &cancellables)

        mockWebSocket.send(symbol: "AAPL", price: 1000)

        wait(for: [expectation], timeout: 10)
    }

}
