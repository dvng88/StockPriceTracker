//
//  MockPriceStreamingEngine.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 05/03/2026.
//

@testable import PriceTrackerApp

class MockPriceStreamingEngine: PriceStreamingEngine {
    private(set) var startCalled = false
    private(set) var stopCalled = false
    private(set) var receivedSymbols: [Stock] = []

    func start(symbols: [Stock]) {
        startCalled = true
        receivedSymbols = symbols
    }

    func stop() {
        stopCalled = true
    }
}
