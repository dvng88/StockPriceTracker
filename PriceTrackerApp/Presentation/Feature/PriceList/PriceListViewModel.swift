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


    private var cancellables  = Set<AnyCancellable>()

    private let stockObserver: StockObserverUseCase
    private let toggleUseCase: TogglePriceUseCase

    init(stockObserver: StockObserverUseCase,
         toggleUseCase: TogglePriceUseCase) {
        self.stockObserver = stockObserver
        self.toggleUseCase = toggleUseCase

        setupStockObserverBinding()
        setupConnectionBinding()
    }

    private func setupStockObserverBinding() {
        stockObserver.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] resStocks in
                self?.stocks = resStocks
            }
            .store(in: &cancellables)
    }

    private func setupConnectionBinding() {
        stockObserver.connectionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] connected in
                self?.isConnected = connected
            }
            .store(in: &cancellables)
    }

    func togglePriceFeed() {
        isRunning.toggle()
        
        isRunning ? toggleUseCase.start() : toggleUseCase.stop()
    }
}
