//
//  AppRouter.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation
import SwiftUI
import Combine

class AppRouter: ObservableObject {
    enum Route: Hashable {
        case details(String)
    }

    @Published var path = NavigationPath()

    func push(_ route: Route) {
        path.append(route)
    }
}

struct AppRouterView: View {
    @StateObject var router: AppRouter
    let diContainer: DIContainerProtocol
    var body: some View {
        NavigationStack(path: $router.path) {
            PriceListScreen(viewModel: diContainer.makePriceListViewModel(), router: router)
                .navigationDestination(for: AppRouter.Route.self) { route in
                    switch route {
                    case .details(let symbol):
                        StockDetailScreen(viewModel: diContainer.makeStockDetailViewModel(symbol))
                    }
                }
        }
    }
}
