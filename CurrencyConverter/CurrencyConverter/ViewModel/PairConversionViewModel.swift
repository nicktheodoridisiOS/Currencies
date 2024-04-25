//
//  PairConversionViewModel.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 22/4/24.
//

import Foundation

class PairConversionViewModel: ObservableObject{
    
    @Published var pairConversion: [PairConversion] = []
    
    func fetchPairConversion(base: String,target: String) async{
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/b1b71f168dab8cfbff14f4d3/pair/\(base)/\(target)") else {
            return
        }
                
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            do {
                let pairConversions = try JSONDecoder().decode(PairConversion.self, from: data)
                DispatchQueue.main.async {
                    self.pairConversion = [pairConversions]
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
