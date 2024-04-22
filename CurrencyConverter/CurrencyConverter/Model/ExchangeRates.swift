//
//  ExchangeRates.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 22/4/24.
//

import Foundation

struct ExchangeRates: Codable , Hashable {
    var result: String
    var documentation: URL
    var terms_of_use: URL
    var time_last_update_unix: Double
    var time_last_update_utc: String
    var time_next_update_unix: Double
    var time_next_update_utc: String
    var base_code: String
    var conversion_rates: [String: Double]
}

