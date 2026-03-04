//
//  PriceListViewModel.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 04/03/2026.
//

import Foundation
import Combine

class PriceListViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var isConnected: Bool = false
    @Published var isRunning: Bool = false

    private let webSocket = WebSocketService()

    private let symbols = ["AAPL","GOOG","TSLA","AMZN","MSFT"]
    private var timerCancellable: AnyCancellable?
    private var cancellables  = Set<AnyCancellable>()

    init() {
        setupStocks()
        webSocket.connect()
        start(symbols: symbols)

        webSocket.messagePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] msg in
                print("Msg: \(msg)")
                self?.update(byMessage: msg)
            }
            .store(in: &cancellables)
    }

    private func setupStocks() {
        stocks = symbols.map {
            Stock(symbol: $0, price: Double.random(in: 100...500), previousPrice: 0)
        }
    }

    private func start(symbols: [String]) {
        timerCancellable = Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.stocks.forEach {
                    let price = $0.price * (Double.random(in: 0.95...1.05))
                    self?.webSocket.send(symbol: $0.symbol, price: price)
                }
            }
    }

    func update(byMessage msg: String) {
        let parts = msg.split(separator: ":", maxSplits: 1)
        guard parts.count == 2, let price = Double(parts[1]) else { return }

        let symbol = String(parts[0])

        guard let index = stocks.firstIndex(where: { $0.symbol == symbol }) else { return }

        stocks[index].previousPrice = stocks[index].price
        stocks[index].price = price

        stocks.sort { $0.price > $1.price }
    }



}
