//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 21/5/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var itemSelected  = 0
    @State private var itemSelected2 = 0
    @State private var amount : String  = ""
    
    private let currencies = ["USD" , "EUR" ,"GBP","CAD","AUD"]
    private let flags = ["🇺🇸","🇪🇺","🇬🇧","🇨🇦","🇦🇺"]
    
   
    @State private var scaleAmount : CGFloat = 0.0
    
    var body: some View {
        //        NavigationView{
        //            Form{
        //                Section(header: Text("")) {
        //                    TextField("Enter an amount",text: $amount)
        //                        .keyboardType(.decimalPad)
        //
        //                    Picker(selection: $itemSelected, label: Text("From").foregroundColor(.gray)){
        //                        ForEach(0 ..< currencies.count, id: \.self){ index in
        //                            Text(self.currencies[index]).tag(index)
        //                            }
        //                        }
        //
        //                    Picker(selection: $itemSelected2, label: Text("To").foregroundColor(.gray)){
        //                        ForEach(0 ..< currencies.count,id: \.self){ index in
        //                            Text(self.currencies[index]).tag(index)
        //                            }
        //                        }
        //
        //                    }
        //
        //                Section(header: Text("Convertion")) {
        //                    HStack{
        //                        Text("\(convert(amount))  \(currencies[itemSelected2])")
        //                            .foregroundColor(.green)
        //                        Spacer()
        //                        let index = currencies.firstIndex(where: {$0 == "\(currencies[itemSelected2])"})
        //                        Text("\(flags[index!])")
        //                    }
        //                }
        //            }
        //            .navigationTitle("Currency Converter")
        //            }
        //            .scaleEffect(scaleAmount)
        //            .onAppear{
        //                withAnimation(.spring()){
        //                    scaleAmount = 1.0
        //                }
        //        }
        VStack{
            CurrencyListView()
        }
    }
    
    func convert(_ convert: String) -> String{
        var conversion: Double = 1.0
        let amount  = Double(convert.doubleValue)
        let selectCurrency = currencies[itemSelected]
        let to = currencies[itemSelected2]
        
        let euroRates = ["USD": 1.15 , "EUR":1.0,"GBP":0.86,"CAD":1.45,"AUD":1.62]
        let usdRates  = ["USD": 1.0 , "EUR":0.92,"GBP":0.8,"CAD":1.34,"AUD":1.5]
        let gbpRates  = ["USD": 1.24 , "EUR":1.15,"GBP":1.0,"CAD":1.67,"AUD":1.87]
        let cadRates  = ["USD": 0.74 , "EUR":0.68,"GBP":0.59,"CAD":1.0,"AUD":1.11]
        let audRates  = ["USD": 0.66 , "EUR":0.61,"GBP":0.53,"CAD":0.89,"AUD":1.0]
        
        switch (selectCurrency){
        case "USD":
            conversion = amount * (usdRates[to] ?? 0.0)
        case "EUR":
            conversion = amount * (euroRates[to] ?? 0.0)
        case "GBP":
            conversion = amount * (gbpRates[to] ?? 0.0)
        case "CAD":
            conversion = amount * (cadRates[to] ?? 0.0)
        case "AUD":
            conversion = amount * (audRates[to] ?? 0.0)
        default:
            print("ERROR")
        }
        
        return String(format: "%.2f", conversion)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
