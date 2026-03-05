//
//  PriceListScreen.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 04/03/2026.
//

import SwiftUI

struct PriceListScreen: View {
    @StateObject var viewModel: PriceListViewModel
    @ObservedObject var router: AppRouter
    var body: some View {
        VStack {
            List(viewModel.stocks) { stock in
                Button {
                    router.push(.details(stock.symbol))
                } label: {
                    StockPriceRow(stock: stock)
                }
                .listRowBackground(
                    flashBackgroundState(stock.flashState)
                        .animation(.easeOut(duration: 0.35), value: stock.flashState)
                )
            }
            .listStyle(.grouped)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text(viewModel.isConnected ? "🟢" : "🔴")
            }

            ToolbarItem(placement: .topBarTrailing) {
                stockToggleButton(isRunning: viewModel.isRunning) {
                    // Change Status
                    viewModel.togglePriceFeed()
                }
            }
        }

    }

    private func flashBackgroundState(_ state: Stock.FlashState) -> some View {
        switch state {
        case .none: Color(.systemBackground)
        case .up: Color.green.opacity(0.3)
        case .down: Color.red.opacity(0.3)
        }
    }

    private func stockToggleButton(isRunning: Bool, action: @escaping () -> Void) -> some View {

        return Button(action: action) {
                Label(isRunning ? "Stop" : "Start",
                      systemImage: isRunning ? "stop.fill" : "play.fill")
            }
            .buttonStyle(.borderedProminent)
            .tint(isRunning ? .red : .green)
            .animation(.easeInOut(duration: 0.2), value: isRunning)
    }

}

#Preview {
    PriceListScreen(
        viewModel: MockDIContainer().makePriceListViewModel(),
        router: AppRouter()
    )
}
