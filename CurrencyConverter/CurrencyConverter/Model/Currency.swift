//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 26/8/23.
//

import Foundation
import SwiftUI


struct Currency: Identifiable,Hashable{
    var id =  UUID().uuidString
    var currencyName: String
    var currencyValue: Double

}

var currencies = ["USD","EUR","JPY","GBP","AUD","CAD","CHF","CNH"]

