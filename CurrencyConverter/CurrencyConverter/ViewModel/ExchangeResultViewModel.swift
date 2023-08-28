//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 28/8/23.
//

import Foundation

class ExchangeResultViewModel: ObservableObject {
    @Published var exchangeResult: ExchangeResult?
    
    func fetchData(from: String , to: String , amount: String) {
        print(from)
        print(to)
        guard let url = URL(string: "https://api.exchangerate.host/convert?from=\(from)&to=\(to)&amount=\(amount)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let exchangeResult = try decoder.decode(ExchangeResult.self, from: data)
                    DispatchQueue.main.async {
                        self.exchangeResult = exchangeResult
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}



