//
//  ExchangeRatesViewModel.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 22/4/24.
//

import Foundation

class ExchangeRatesViewModel: ObservableObject{
    @Published var exchangeRates: [String: Double] = [:]

    
    func fetchExchangeRatesList(base: String) async{
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/b1b71f168dab8cfbff14f4d3/latest/\(base)") else {
            return
        }
                
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            do {
                let exchangeRates = try JSONDecoder().decode(ExchangeRates.self, from: data)
                DispatchQueue.main.async {
                    self.exchangeRates  = exchangeRates.conversion_rates
                    print(exchangeRates)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
