//
//  TogglePriceUseCase.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation

protocol TogglePriceUseCase {
    func start()
    func stop()
}

class TogglePriceUseCaseImpl: TogglePriceUseCase {
    private let repository: StockPriceRepositoryProtocol

    init(repository: StockPriceRepositoryProtocol) {
        self.repository = repository
    }

    func start() {
        repository.start()
    }

    func stop() {
        repository.stop()
    }
}
