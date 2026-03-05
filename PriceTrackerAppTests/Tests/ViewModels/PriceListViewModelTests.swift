//
//  PriceListViewModelTests.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 06/03/2026.
//

import XCTest
@testable import PriceTrackerApp

final class PriceListViewModelTests: XCTestCase {

    var viewModel: PriceListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = PriceListViewModel(
            stockObserver: MockStockObserverUseCase(),
            toggleUseCase: MockTogglePriceUseCase()
        )
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testToggleListingUpdateRunningState() {
        viewModel.togglePriceFeed()

        XCTAssertTrue(viewModel.isRunning)
    }

}
