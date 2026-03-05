//
//  MockWebSocketService.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 05/03/2026.
//

import XCTest
import Combine
@testable import PriceTrackerApp

class MockWebSocketService: WebSocketServiceProtocol {
    let messageSubject = PassthroughSubject<String, Never>()
    let connectionSubject = CurrentValueSubject<Bool, Never>(false)

    var stockList: [PriceTrackerApp.StockDTO] = [
        StockDTO(symbol: "AAPL", name: "Apple Inc.", description: "Global technology leader known for the iPhone and high-margin services."),
        StockDTO(symbol: "GOOGL", name: "Alphabet Inc.", description: "Parent of Google, the leader in search, online ads, and YouTube."),
    ]

    private(set) var connectCalled = false
    private(set) var disconnectCalled = false

    var messagePublisher: AnyPublisher<String, Never> {
        messageSubject.eraseToAnyPublisher()
    }

    var connectionPublisher: AnyPublisher<Bool, Never> {
        connectionSubject.eraseToAnyPublisher()
    }

    func connect() {
        connectCalled = true
        connectionSubject.send(true)
    }
    
    func disconnect() {
        disconnectCalled = true
        connectionSubject.send(false)
    }
    
    func send(symbol: String, price: Double) {
        messageSubject.send(String("\(symbol):\(price)"))
    }
}
