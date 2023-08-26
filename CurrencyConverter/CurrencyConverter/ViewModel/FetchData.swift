//
//  FetchData.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 26/8/23.
//

import Foundation

class FetchData: ObservableObject{
    
    @Published var convertionData: [Currency] = []
    @Published var sortedConvertionData: [Currency] = []
    @Published var base = "EUR"
    
    init(){
        fetch()
        sortConvertionData()
    }
    
    func fetch(){
        
        let url = "https://api.exchangerate.host/latest?base=\(base)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!){ (data, _, _) in
            guard let JSONData = data else {return}
            
            do{
                let conversion = try JSONDecoder().decode(Convertion.self, from: JSONData)
                
                DispatchQueue.main.async {
                    self.convertionData = conversion.rates.compactMap({ (key,value) -> Currency? in
                        return Currency(currencyName: key, currencyValue: value)
                    })
                }
                
            }
            catch{
                print(error.localizedDescription)
            }
            
            
        }
        .resume()
    }
    
    func updateData(base: String){
        self.base = base
        self.convertionData.removeAll()
        fetch()
    }
    
    func sortConvertionData(){
        sortedConvertionData = convertionData.sorted(by: {$0.currencyName < $1.currencyName})
    }
    
    
    
    
}
