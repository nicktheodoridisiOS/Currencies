//
//  SettingsView.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 28/8/23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("selectedCurrencyBase") var selectedCurrencyCode: String = "EUR"
    @AppStorage("isDarkModeEnabled") var isDarkModeEnabled = false
    
    let currencyCodes = Array(CurrencyCodes.conversionRates.keys).sorted()

    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(header: Text("GENERAL"), footer: Text("Changing the currency code will update the base in the application.")) {
                        HStack(spacing: 15) {
                            Image(systemName: "globe")
                                .font(.title3)
                                .overlay {
                                    LinearGradient(
                                        gradient: Gradient(colors: [.yellow, .green]),
                                        startPoint: .topTrailing,
                                        endPoint: .bottomLeading)
                                }
                                .mask {
                                    Image(systemName: "globe")
                                        .font(.title3)
                                }
                            
                            Picker("Currency Code", selection: $selectedCurrencyCode) {
                                ForEach(currencyCodes, id: \.self) { currencyCode in
                                    Text("\(currencyCode)").tag(currencyCode).foregroundStyle(.gray)
                                }
                            }
                            .tint(.secondary)
                            .pickerStyle(MenuPickerStyle())
                        }
                    }
                    
                    Section(header: Text("DISPLAY"), footer: Text("Enabling dark mode changes the app's appearance beyond your device settings.")) {
                        HStack(spacing: 15) {
                            Image(systemName: "moon")
                                .font(.title3)
                                .overlay {
                                    LinearGradient(
                                        gradient: Gradient(colors: [.pink, .purple]),
                                        startPoint: .topTrailing,
                                        endPoint: .bottomLeading)
                                }
                                .mask {
                                    Image(systemName: "moon")
                                        .font(.title3)
                                }
                            Toggle("Dark Mode", isOn: $isDarkModeEnabled)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Settings")
        }
    }
    
    func getFlag(currency: String) -> String {
        let base = 127397
        var code = currency
        code.removeLast()
        
        var scalar = String.UnicodeScalarView()
        for i in code.utf16 {
            scalar.append(UnicodeScalar(base + Int(i))!)
        }
        
        return String(scalar)
    }
}
