//
//  CurrencyConverter.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 27/8/23.
//

import SwiftUI



struct ConverterView: View {
    
    @ObservedObject private var exchangeResultViewModel = ExchangeResultViewModel()
    @StateObject var viewModel = FetchData()
    
    @State private var amount: String = ""
    @State private var selectedTargetCurrencyTo: String = "AED"
    
    @Binding var selectedOption: String



    var filteredConvertionData: [Currency] {
        return viewModel.convertionData.sorted(by: {$0.currencyName < $1.currencyName})
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    Section(header: Text("CONVERTER")){
                        TextField("Enter an amount", text: $amount, onEditingChanged: { bool in
                            exchangeResultViewModel.fetchData(from: selectedOption, to: selectedTargetCurrencyTo, amount: amount)
                            
                        })
                    }
                    
                    Section(header: Text("FILTERS")){
                        Picker("From", selection: $selectedOption) {
                            ForEach(filteredConvertionData) { currency in
                                Text("\(getFlag(currency: currency.currencyName)) \(currency.currencyName)").tag(currency.currencyName)
                            }
                        }
                        
                        Picker("To", selection: $selectedTargetCurrencyTo) {
                            ForEach(filteredConvertionData) { currency in
                                Text("\(getFlag(currency: currency.currencyName)) \(currency.currencyName)").tag(currency.currencyName)
                            }
                        }
                    }
                    
                    Section(header: Text("CONVERSION")) {
                        if let result = exchangeResultViewModel.exchangeResult {
                            Text("\(result.result,specifier: "%.2f")")
                                .bold()
                        } else {
                            Text("Submit an amount")
                                .foregroundColor(.secondary.opacity(0.5))
                        }
                    }
                    
                    
                }
            }.navigationTitle("Converter")
        }
        .tint(.green)
    }
    
    
    func getFlag(currency: String) -> String{
        
        let base = 127397
        
        var code = currency
        code.removeLast()
        
        var scalar = String.UnicodeScalarView()
        
        for i in code.utf16{
            scalar.append(UnicodeScalar(base + Int(i))!)
        }
        
        return String(scalar)
    }
    
    
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView(selectedOption: .constant("EUR"))
    }
}




//VStack {
//    if let result = exchangeResultViewModel.exchangeResult {
//        Text("Result: \(result.result)")
//    } else {
//        Text("Loading data...")
//    }
//}
//.onAppear {
//    exchangeResultViewModel.fetchData(from: "EUR", to: "USD", amount: 1)
//}
