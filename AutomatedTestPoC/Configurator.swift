//
//  Configurator.swift
//  Caching
//
//  Created by AMALITECH MACBOOK on 28/04/2023.
//

import Foundation
final class Configurator {
    static let shared = Configurator()

    private init() {}

    private func getSecretItem(isURL: Bool = true, baseURL: Secrets) -> String {
        let fetchedLink = Bundle.main.object(forInfoDictionaryKey: baseURL.rawValue) as? String
        guard let secretURL = fetchedLink, !(secretURL.isEmpty) else {
            fatalError("URL is empty")
        }
        return isURL ? "https://\(secretURL)" : secretURL
    }

    lazy var baseURL: String = {
        getSecretItem(baseURL: .baseURL)
    }()

    lazy var apikey: String = {
        getSecretItem(isURL: false, baseURL: .apiKey)
    }()

    private enum Secrets: String {
        case baseURL = "BASE_API_URL"
        case apiKey = "API_SECRET_KEY"
    }
}
