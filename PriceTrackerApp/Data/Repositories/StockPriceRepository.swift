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
        guard let symbolPart = msg.splitSymbolPrice else { return }
        let symbol = symbolPart.symbol
        let price = symbolPart.price

        guard let index = stocks.firstIndex(where: { $0.symbol == symbol }) else { return }

        let previousPrice = stocks[index].price
        stocks[index].previousPrice = previousPrice
        stocks[index].price = price
        stocks[index].flashState = price >= previousPrice ? .up : .down

        stocks.sort { $0.price > $1.price }

        stockSubject.send(stocks)

        // Clear flash after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self else { return }
            guard let i = self.stocks.firstIndex(where: { $0.symbol == symbol }) else { return }
            self.stocks[i].flashState = .none
            self.stockSubject.send(self.stocks)
        }
    }
}
