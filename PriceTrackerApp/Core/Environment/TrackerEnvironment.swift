//
//  TrackerEnvironment.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation

protocol TrackerEnvironment {
    var baseURL: URL { get }
}

struct DefaultTrackerEnvironment: TrackerEnvironment {
    let baseURL: URL = AppConfig.baseURL
}
