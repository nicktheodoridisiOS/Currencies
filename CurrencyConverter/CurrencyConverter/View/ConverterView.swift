//
//  CurrencyConverter.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 27/8/23.
//

import SwiftUI

struct ConverterView: View {
    
    @AppStorage("selectedBase") var selectedBase: String = "AED"
    @AppStorage("selectedTarget") var selectedTarget: String = "AFN"
    @AppStorage("lastConvertedAmount") var lastConvertedAmount: String = ""
    @AppStorage("lastAmount") var lastAmount: String = ""
    
    @StateObject var pairConversionViewModel = PairConversionViewModel()
    
    @State private var amount: String = ""
    @State private var convertedAmount: String = ""
    
    let currencyCodes = Array(CurrencyCodes.conversionRates.keys).sorted()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("CONVERT")) {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Picker("From", selection: $selectedBase) {
                        ForEach(currencyCodes, id: \.self) { currencyCode in
                            Text("\(currencyCode)").tag(currencyCode).foregroundStyle(.secondary)
                        }
                    }
                    .tint(.secondary)
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("To", selection: $selectedTarget) {
                        ForEach(currencyCodes, id: \.self) { currencyCode in
                            Text("\(currencyCode)").tag(currencyCode).foregroundStyle(.secondary)
                        }
                    }
                    .tint(.secondary)
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section(header: Text("CONVERTION")){
                    Text("\(convertedAmount)")
                }
                
                if !lastConvertedAmount.isEmpty{
                    Section(header: Text("LAST CONVERTION")){
                        if !lastConvertedAmount.isEmpty {
                            HStack{
                                Text("\(lastAmount) \(selectedBase)")
                                Image(systemName: "arrow.left.arrow.right").font(.caption).foregroundStyle(.secondary)
                                Text("\(lastConvertedAmount)")
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Converter")
            .onChange(of: selectedBase) { convertCurrency() }
            .onChange(of: selectedTarget) { convertCurrency() }
            .onChange(of: amount) { convertCurrency() }
            .task {
                await pairConversionViewModel.fetchPairConversion(base: selectedBase, target: selectedTarget)
            }
        }
    }
    
    func convertCurrency() {
        guard let amountToConvert = Double(amount),
              let conversionRate = pairConversionViewModel.pairConversion.first?.conversion_rate else {
            convertedAmount = "Amount not inserted"
            lastConvertedAmount = "\(selectedTarget)"
            return
        }
        
        let result = amountToConvert * conversionRate
        if amount != "" {
            lastAmount  = amount
        }
        else{
            lastAmount = ""
        }
        convertedAmount = String(format: "%.2f \(selectedTarget)", result)
        lastConvertedAmount = "\(convertedAmount)"
    }
}
