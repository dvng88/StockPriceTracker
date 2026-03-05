//
//  PriceStreamingEngine.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation
import Combine

protocol PriceStreamingEngine {
    func start(symbols: [Stock])
    func stop()
}

class DefaultPriceStreamingEngine: PriceStreamingEngine {
    private let webSocket: WebSocketServiceProtocol
    private var timer: AnyCancellable?

    init(webSocket: WebSocketServiceProtocol) {
        self.webSocket = webSocket
    }

    func start(symbols: [Stock]) {
        timer = Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                symbols.forEach {
                    let price = $0.price + Double.random(in: -5...5)
                    self?.webSocket.send(symbol: $0.symbol, price: price)
                }
            }
    }

    func stop() {
        timer?.cancel()
    }
}
