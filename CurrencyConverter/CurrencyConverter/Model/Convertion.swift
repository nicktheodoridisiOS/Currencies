//
//  Convertion.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 26/8/23.
//

import SwiftUI
import Foundation


struct Convertion: Decodable{
    var rates = [String: Double]()
    var base: String
    var date: String
  
}


