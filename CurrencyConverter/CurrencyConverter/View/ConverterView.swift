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
    
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("CONVERT")) {
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
                    TextField("0 \(selectedBase)", text: $amount)
                        .keyboardType(.decimalPad)
                    Text(amount == "" ? "0 \(selectedTarget)"  : "\(convertedAmount)")
                        .foregroundStyle(amount == "" ? .secondary : .primary )
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
            .onChange(of: selectedBase) { newValue in
                Task {
                    await fetchConversionRates()
                }
            }
            .onChange(of: selectedTarget) { newValue in
                Task {
                    await fetchConversionRates()
                }
            }
            .onChange(of: amount) { newValue in
                convertCurrency()
            }
            .task {
                await fetchConversionRates()
            }
        }
    }
    
    func fetchConversionRates() async {
        await pairConversionViewModel.fetchPairConversion(base: selectedBase, target: selectedTarget)
        convertCurrency()
    }
    
    func convertCurrency() {
        guard !amount.isEmpty, let amountToConvert = Double(amount),
              let conversionRate = pairConversionViewModel.pairConversion.first?.conversion_rate else {
            convertedAmount = "Enter a valid amount"
            lastConvertedAmount = ""
            return
        }
        
        let result = amountToConvert * conversionRate
        convertedAmount = String(format: "%.2f \(selectedTarget)", result)
        
        lastAmount = amount
        lastConvertedAmount = "\(convertedAmount)"
    }
}
