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
                            }
                                .foregroundStyle(stock.isPriceUp() ? Color.green : Color.red)
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

#Preview {
    StockDetailScreen(
        viewModel: MockDIContainer().makeStockDetailViewModel("AAPL")
        )
}
