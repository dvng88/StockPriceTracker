//
//  PriceStreamingEngine.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation
import Combine

protocol PriceStreamingEngine {
    func start(symbols: [String])
    func stop()
}

class DefaultPriceStreamingEngine: PriceStreamingEngine {
    private let webSocket: WebSocketServiceProtocol
    private var timer: AnyCancellable?

    init(webSocket: WebSocketServiceProtocol) {
        self.webSocket = webSocket
    }

    func start(symbols: [String]) {
        timer = Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                symbols.forEach {
                    let price = Double.randomGenerator
                    self?.webSocket.send(symbol: $0, price: price)
                }
            }
    }

    func stop() {
        timer?.cancel()
    }
}
