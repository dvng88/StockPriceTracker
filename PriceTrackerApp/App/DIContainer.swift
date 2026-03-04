//
//  DIContainer.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation

protocol DIContainerProtocol {
    var webSocket: WebSocketServiceProtocol { get }
}

class DIContainer: DIContainerProtocol {
    internal let webSocket: WebSocketServiceProtocol
    init() {
        let enviornment: TrackerEnvironment = DefaultTrackerEnvironment()
        webSocket = WebSocketService(baseURL: enviornment.baseURL)
    }
}

class MockDIContainer: DIContainerProtocol {
    let webSocket: WebSocketServiceProtocol
    init() {
        let enviornment: TrackerEnvironment = DefaultTrackerEnvironment()
        webSocket = WebSocketService(baseURL: enviornment.baseURL)
    }
}
