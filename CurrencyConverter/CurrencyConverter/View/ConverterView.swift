//
//  CurrencyConverter.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 27/8/23.
//

import SwiftUI

import SwiftUI

struct ConverterView: View {
    
    @AppStorage("selectedBase") var selectedBase: String = "AED"
    @AppStorage("selectedTarget") var selectedTarget: String = "AFN"
    
    @StateObject var pairConversionViewModel = PairConversionViewModel()
    
    @State private var amount: String = ""
    @State private var convertedAmount: String = "" // To store the converted amount
    
    let currencyCodes = Array(CurrencyCodes.conversionRates.keys).sorted()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("CONVERT")) {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad) // Ensures that only numbers can be entered
                    
                    Picker("From", selection: $selectedBase) {
                        ForEach(currencyCodes, id: \.self) { currencyCode in
                            Text("\(currencyCode)").tag(currencyCode).foregroundStyle(.gray)
                        }
                    }
                    .tint(.secondary)
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("To", selection: $selectedTarget) {
                        ForEach(currencyCodes, id: \.self) { currencyCode in
                            Text("\(currencyCode)").tag(currencyCode).foregroundStyle(.gray)
                        }
                    }
                    .tint(.secondary)
                    .pickerStyle(MenuPickerStyle())
                    
                    Button("Convert") {
                        convertCurrency()
                    }
                    
                    Text("Converted Amount: \(convertedAmount)")
                        .bold()
                }
                
            }
            .task {
                await pairConversionViewModel.fetchPairConversion(base: selectedBase, target: selectedTarget)
            }
        }
    }
    
    func convertCurrency() {
        guard let amountToConvert = Double(amount),
              let conversionRate = pairConversionViewModel.pairConversion.first?.conversion_rate else {
            convertedAmount = "Invalid input or rate"
            return
        }
        
        let result = amountToConvert * conversionRate
        convertedAmount = String(format: "%.2f", result)
    }
}
