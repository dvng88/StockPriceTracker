//
//  PriceTrackerAppApp.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 04/03/2026.
//

import SwiftUI

@main
struct PriceTrackerAppApp: App {
    let diContainer = DIContainer()
    let router = AppRouter()
    var body: some Scene {
        WindowGroup {
            AppRouterView(router: router, diContainer: diContainer)
        }
    }
}
