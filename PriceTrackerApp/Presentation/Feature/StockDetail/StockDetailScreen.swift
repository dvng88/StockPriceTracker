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
            Grid(alignment: .leading, verticalSpacing: 16) {
                GridRow {
                    Group {
                        Text("Symbol")
                        Text(":")
                    }
                        .foregroundColor(.secondary)

                    Text(viewModel.stock.symbol)
                }


                Divider()

                GridRow {
                    Group {
                        Text("Price")
                        Text(":")
                    }
                        .foregroundColor(.secondary)
                    PriceTextView(price: viewModel.stock.price)
                }

                Divider()

                GridRow {
                    Group {
                        Text("Name")
                        Text(":")
                    }
                        .foregroundColor(.secondary)
                    Text(viewModel.stock.name)
                }

                Divider()

                GridRow(alignment: .top) {
                    Group {
                        Text("Description")
                        Text(":")
                    }
                        .foregroundColor(.secondary)
                    Text(viewModel.stock.description)
                }

                Divider()
            }

            Spacer()
        }
        .padding(16)
        .navigationTitle(viewModel.stock.name)
    }
}

#Preview {
    StockDetailScreen(
        viewModel: StockDetailViewModel(
            stock: Stock.mock()
        )
    )
}
