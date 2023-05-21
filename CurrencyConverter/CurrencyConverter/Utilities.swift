//
//  Utilities.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 21/5/23.
//

import Foundation

extension String{
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double{
        String.numberFormatter.decimalSeparator = "."
        if let result = String.numberFormatter.number(from: self){
            return result.doubleValue
        }
        else{
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self){
                return result.doubleValue
            }
        }
        return 0
    }
}
