//
//  StockPriceRepository.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation
import Combine

protocol StockPriceRepositoryProtocol {
    var stockPublisher: AnyPublisher<[Stock], Never> { get }
    var connectionPublisher: AnyPublisher<Bool, Never> { get }

    func start()
    func stop()
}

class StockPriceRepository: StockPriceRepositoryProtocol {
    private var stocks: [Stock] = []
    private let stockSubject = CurrentValueSubject<[Stock], Never>([])

    private var cancellables = Set<AnyCancellable>()

    var stockPublisher: AnyPublisher<[Stock], Never> {
        stockSubject.eraseToAnyPublisher()
    }

    var connectionPublisher: AnyPublisher<Bool, Never> {
        webSocket.connectionPublisher
    }

    private var symbols: [StockDTO] {
        webSocket.stockList
    }

    private let webSocket: WebSocketServiceProtocol
    private let streamingEngine: PriceStreamingEngine

    init(webSocket: WebSocketServiceProtocol, streamingEngine: PriceStreamingEngine) {
        self.webSocket = webSocket
        self.streamingEngine = streamingEngine

        setupStocks()
        setupMessagePublisherBinding()
    }

    private func setupStocks() {
        stocks = symbols.map {
            Stock(symbol: $0.symbol, name: $0.name, description: $0.description, price: Double.randomGenerator, previousPrice: 0)
        }
        stockSubject.send(stocks)
    }

    func start() {
        webSocket.connect()
        streamingEngine.start(symbols: stocks)
    }

    func stop() {
        streamingEngine.stop()
        webSocket.disconnect()
    }

    private func setupMessagePublisherBinding() {
        webSocket.messagePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] msg in
                print("Msg: \(msg)")
                self?.updateStock(byMessage: msg)
            }
            .store(in: &cancellables)
    }

    private func updateStock(byMessage msg: String) {
        let parts = msg.split(separator: ":", maxSplits: 1)
        guard parts.count == 2, let price = Double(parts[1]) else { return }

        let symbol = String(parts[0])

        guard let index = stocks.firstIndex(where: { $0.symbol == symbol }) else { return }

        stocks[index].previousPrice = stocks[index].price
        stocks[index].price = price

        stocks.sort { $0.price > $1.price }

        stockSubject.send(stocks)
    }
}
