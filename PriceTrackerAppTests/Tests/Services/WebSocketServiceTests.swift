//
//  WebSocketServiceTests.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 06/03/2026.
//

import XCTest
import XCTest
import Combine
@testable import PriceTrackerApp

final class WebSocketServiceTests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []

    func testConnectPublishesConnectedState() {
        let mock = MockWebSocketService()
        let expectation = expectation(description: "Connected")

        mock.connectionPublisher
            .dropFirst()
            .sink { isConnected in
                XCTAssertTrue(isConnected)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        mock.connect()

        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(mock.connectCalled)
    }

    func testSendPublishesMessage() {
        let mock = MockWebSocketService()
        let expectation = expectation(description: "Message received")


        mock.messagePublisher
            .sink { symbolAndPrice in
                guard let sp = symbolAndPrice.splitSymbolPrice else { return }
                let symbol = sp.symbol
                let price = sp.price

                XCTAssertEqual(symbol, "AAPL")
                XCTAssertEqual(price, 150)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        mock.send(symbol: "AAPL", price: 150)

        wait(for: [expectation], timeout: 1)
    }
}
