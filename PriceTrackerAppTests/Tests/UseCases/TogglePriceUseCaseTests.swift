//
//  TogglePriceUseCaseTests.swift
//  PriceTrackerAppTests
//
//  Created by Devang Shah on 06/03/2026.
//

import XCTest
@testable import PriceTrackerApp

final class TogglePriceUseCaseTests: XCTestCase {

    var repo: MockStockPriceRepository!
    var useCase: TogglePriceUseCaseImpl!


    override func setUp() {
        super.setUp()
        repo = MockStockPriceRepository()
        useCase = TogglePriceUseCaseImpl(repository: repo)
    }

    override func tearDown() {
        repo = nil
        useCase = nil
        super.tearDown()
    }

    func testStartCallsRepositoryStart() {
        useCase.start()

        XCTAssertTrue(repo.startCalled)
    }

    func testStopCallsRepositoryStop() {
        useCase.stop()

        XCTAssertTrue(repo.stopCalled)
    }

}
