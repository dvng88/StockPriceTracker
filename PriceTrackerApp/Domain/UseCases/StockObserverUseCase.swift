//
//  StockObserverUseCase.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation
import Combine

protocol StockObserverUseCase {
    func execute() -> AnyPublisher<[Stock], Never>
    var connectionPublisher: AnyPublisher<Bool, Never> { get }
}

class StockObserverUseCaseImpI: StockObserverUseCase {
    private let repository: StockPriceRepositoryProtocol

    var connectionPublisher: AnyPublisher<Bool, Never> {
        repository.connectionPublisher
    }

    init(repository: StockPriceRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[Stock], Never> {
        repository.stockPublisher
    }
}
