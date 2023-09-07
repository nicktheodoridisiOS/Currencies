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
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    
    
    var filteredConvertionData: [Currency] {
        return viewModel.convertionData.sorted(by: {$0.currencyName < $1.currencyName})
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    Section(header: Text("GENERAL"),footer: Text("Changing the currency base to the desired one will automatically update the base in the currency converter as well.")){
                        HStack(spacing: 15){
                            
                            Image(systemName: "globe")
                                .font(.title3)
                                .overlay{
                                    LinearGradient(
                                        gradient: Gradient(colors:[
                                            .yellow,
                                            .green]),
                                        startPoint:
                                                .topTrailing,
                                        endPoint:
                                                .bottomLeading)
                                }
                                .mask{
                                    Image(systemName: "globe")
                                        .font(.title3)
                                }
                            
                            Picker("Base", selection: $selectedOption) {
                                ForEach(filteredConvertionData) { currency in
                                    Text("\(getFlag(currency: currency.currencyName)) \(currency.currencyName)").tag(currency.currencyName)
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("DISPLAY"),footer: Text("Enabling dark mode is going to change the entire appearance of the application, beyond your device's general settings. ")){
                        HStack(spacing: 15){
                            Image(systemName: "moon")
                                .font(.title3)
                                .overlay{
                                    LinearGradient(
                                        gradient: Gradient(colors:[
                                            .pink,
                                            .purple]),
                                        startPoint:
                                                .topTrailing,
                                        endPoint:
                                            .bottomLeading)
                                }
                                .mask{
                                    Image(systemName: "moon")
                                        .font(.title3)
                                }
                            Toggle("Dark Mode" , isOn: $isDarkModeEnabled)
                        }
                    }
                    
                    
                }
                .listStyle(.insetGrouped)
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

