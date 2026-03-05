//
//  StockDetailScreen.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import SwiftUI

struct StockDetailScreen: View {
    @StateObject var viewModel: StockDetailViewModel
    var body: some View {
        VStack(alignment: .leading) {
            if let stock = viewModel.stock {
                Grid(alignment: .leading, verticalSpacing: 16) {
                    GridRow {
                        Group {
                            Text("Symbol")
                            Text(":")
                        }
                        .foregroundColor(.secondary)

                        Text(stock.symbol)
                    }

                    Divider()

                    GridRow {
                        Group {
                            Text("Price")
                            Text(":")
                        }
                        .foregroundColor(.secondary)
                        HStack(spacing: 4) {
                            Group {
                                PriceTextView(price: stock.price)

                                Text(stock.isPriceUp() ? "↑" : "↓")
                                    .opacity(stock.flashState != .none ? 1 : 0)
                            }
                            .foregroundStyle(priceDirectionColor(stock.flashState))
                        }
                    }

                    Divider()

                    GridRow {
                        Group {
                            Text("Name")
                            Text(":")
                        }
                        .foregroundColor(.secondary)
                        Text(stock.name)
                    }

                    Divider()

                    GridRow(alignment: .top) {
                        Group {
                            Text("Description")
                            Text(":")
                        }
                        .foregroundColor(.secondary)
                        Text(stock.description)
                    }

                    Divider()
                }
            }
            Spacer()
        }
        .padding(16)
        .navigationTitle(viewModel.stock?.name ?? "")
    }
}

extension StockDetailScreen {
    private func priceDirectionColor(_ state: Stock.FlashState) -> Color {
        switch state {
        case .none:
            Color.black
        case .up:
            Color.green
        case .down:
            Color.red
        }
    }
}

#Preview {
    StockDetailScreen(
        viewModel: MockDIContainer().makeStockDetailViewModel("AAPL")
        )
}
