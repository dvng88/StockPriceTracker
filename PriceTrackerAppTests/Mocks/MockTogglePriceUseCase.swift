//
//  MockTogglePriceUseCase.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 05/03/2026.
//

@testable import PriceTrackerApp

class MockTogglePriceUseCase: TogglePriceUseCase {
    private(set) var startCalled = false
    private(set) var stopCalled = false

    func start() {
        startCalled = true
    }
    
    func stop() {
        stopCalled = true
    }
}
