//
//  PriceStreamingEngineTests.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 06/03/2026.
//

import XCTest
@testable import PriceTrackerApp
import Combine

final class PriceStreamingEngineTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []

    private var mockWebSocket: MockWebSocketService!
    private var engine: DefaultPriceStreamingEngine!

    override func setUp() {
        super.setUp()
        mockWebSocket = MockWebSocketService()
        engine = DefaultPriceStreamingEngine(webSocket: mockWebSocket)
    }

    override func tearDown() {
        engine.stop()
        mockWebSocket = nil
        engine = nil
        super.tearDown()
    }

    func testStartShouldSendPricesToWebSocket() {

        let symbols = [
            Stock(symbol: "AAPL", name: "Apple", description: "", price: 100),
            Stock(symbol: "TSLA", name: "Tesla", description: "", price: 200)
        ]

        var receivedSymbols = [Stock]()

        let expectation = expectation(description: "Price updates sent")

        engine.start(symbols: symbols)

        mockWebSocket.messagePublisher
            .sink { symbolAndPrice in
                guard let symbolPrice = symbolAndPrice.splitSymbolPrice else { return }
                let symbol = symbolPrice.symbol

                guard var findStock = symbols.first(where: { $0.symbol == symbol }) else {
                    XCTFail("Expected symbol, but not found")
                    return
                }
                findStock.price = symbolPrice.price
                receivedSymbols.append(findStock)

                if receivedSymbols.count == symbols.count {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 3)
    }
}
