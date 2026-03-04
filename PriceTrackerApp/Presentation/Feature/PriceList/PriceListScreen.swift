//
//  PriceListScreen.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 04/03/2026.
//

import SwiftUI

struct PriceListScreen: View {
    @StateObject var viewModel: PriceListViewModel = PriceListViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(viewModel.stocks, id: \.id) { stock in
                            StockPriceRow(stock: stock)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text(viewModel.isConnected ? "🟢" : "🔴")
                }

                ToolbarItem(placement: .topBarTrailing) {
                    stockToggleButton(isRunning: viewModel.isRunning) {
                        // Change Status
                    }
                }
            }
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
    PriceListScreen()
}
