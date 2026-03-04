//
//  AppConfig.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import Foundation

enum AppConfig {
    private enum EnvironmentKeyNames {
        static let baseURL = "BASE_URL"
        static let baseProtocol = "PROTOCOL"
    }

    private static func value(for key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String,
              !value.isEmpty else {
            fatalError("Missing config value for key: \(key)")
        }
        return value
    }

    static var baseURL: URL {
        let baseURLString = value(for: AppConfig.EnvironmentKeyNames.baseURL)

        guard let baseURL = URL(string: value(for: AppConfig.EnvironmentKeyNames.baseProtocol) + "://" + baseURLString) else {
            fatalError("Invalid base URL")
        }
        return baseURL
    }
}
