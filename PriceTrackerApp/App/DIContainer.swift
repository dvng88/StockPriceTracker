//
//  DIContainer.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation

protocol DIContainerProtocol {
    var webSocket: WebSocketServiceProtocol { get }

    func makePriceListViewModel() -> PriceListViewModel
    func makeStockDetailViewModel(_ symbol: String) -> StockDetailViewModel
}

class DIContainer: DIContainerProtocol {
    internal let webSocket: WebSocketServiceProtocol

    lazy var streamingEngine: PriceStreamingEngine = {
        DefaultPriceStreamingEngine(
            webSocket: webSocket
        )
    }()

    lazy var repository: StockPriceRepositoryProtocol = {
        StockPriceRepository(
            webSocket: webSocket,
            streamingEngine: streamingEngine
        )
    }()

    init() {
        let enviornment: TrackerEnvironment = DefaultTrackerEnvironment()
        webSocket = WebSocketService(baseURL: enviornment.baseURL)
    }

    func makePriceListViewModel() -> PriceListViewModel {
        PriceListViewModel(
            stockObserver: StockObserverUseCaseImpI(repository: repository),
            toggleUseCase: TogglePriceUseCaseImpl(repository: repository)
        )
    }

    func makeStockDetailViewModel(_ symbol: String) -> StockDetailViewModel {
        StockDetailViewModel(
            stockSymbol: symbol,
            stockObserverUseCase: StockDetailObserverUseCaseImpl(repository: repository)
        )
    }
}

class MockDIContainer: DIContainerProtocol {
    let webSocket: WebSocketServiceProtocol

    lazy var streamingEngine: PriceStreamingEngine = {
        DefaultPriceStreamingEngine(
            webSocket: webSocket
        )
    }()

    lazy var repository: StockPriceRepositoryProtocol = {
        StockPriceRepository(
            webSocket: webSocket,
            streamingEngine: streamingEngine
        )
    }()

    init() {
        let enviornment: TrackerEnvironment = DefaultTrackerEnvironment()
        webSocket = WebSocketService(baseURL: enviornment.baseURL)
    }

    func makePriceListViewModel() -> PriceListViewModel {
        PriceListViewModel(
            stockObserver: StockObserverUseCaseImpI(repository: repository),
            toggleUseCase: TogglePriceUseCaseImpl(repository: repository)
        )
    }

    func makeStockDetailViewModel(_ symbol: String) -> StockDetailViewModel {
        StockDetailViewModel(
            stockSymbol: symbol,
            stockObserverUseCase: StockDetailObserverUseCaseImpl(repository: repository)
        )
    }
}
