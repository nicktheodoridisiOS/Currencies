//
//  PairConversion.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 22/4/24.
//

import Foundation

struct PairConversion: Codable{
    var base_code: String
    var target_code: String
    var conversion_rate: Double
}
