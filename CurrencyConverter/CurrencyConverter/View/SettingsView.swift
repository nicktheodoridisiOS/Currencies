//
//  SettingsView.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 28/8/23.
//

import SwiftUI

struct SettingsView: View {
    
    
    @ObservedObject private var exchangeResultViewModel = ExchangeResultViewModel()
    @StateObject var viewModel = FetchData()
    
    @Binding var selectedOption: String
    

    var filteredConvertionData: [Currency] {
        return viewModel.convertionData.sorted(by: {$0.currencyName < $1.currencyName})
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    Section(header: Text("GENERAL")){
                        Picker("Currency Base", selection: $selectedOption) {
                            ForEach(filteredConvertionData) { currency in
                                Text("\(getFlag(currency: currency.currencyName)) \(currency.currencyName)").tag(currency.currencyName)
                            }
                        }
                    }
                }
            }.navigationTitle("Settings")
        }
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedOption: .constant("EUR"))
    }
}

