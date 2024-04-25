//
//  CurrencyConverterGenerator.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 26/8/23.
//

import SwiftUI

struct ExchangesView: View {
    
    @AppStorage("selectedCurrencyBase") var selectedCurrencyCode: String = "EUR"
    
    @StateObject var exchangeRatesViewModel = ExchangeRatesViewModel()
    
    @State private var searchText: String = ""
    
    @State private var scaleAmount: CGFloat = 0
    @State var isSorted: Bool = false
    
    @State private var opacityView: CGFloat = 0
    @State private var lastFetchedCurrency: String = ""
    @State private var isLoading: Bool = false
    
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading || exchangeRatesViewModel.exchangeRates.isEmpty{
                    ProgressView()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment:.leading){
                            Text("Browse Currency Codes").font(.title3).bold()
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(searchResults, id: \.key) { key, value in
                                    CurrencyRateView(currency: key, rate: value)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .opacity(opacityView)
                    .onAppear{
                        withAnimation(.smooth){
                            opacityView = 1
                        }
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Currency Code")
            .navigationTitle("Exchanges")
        }
        .task {
            if exchangeRatesViewModel.exchangeRates.isEmpty || lastFetchedCurrency != selectedCurrencyCode {
                isLoading = true
                lastFetchedCurrency = selectedCurrencyCode
//                await exchangeRatesViewModel.fetchExchangeRatesList(base: selectedCurrencyCode)
                isLoading = false
            }
        }
        .tint(Color.green)
    }
    
    var searchResults: [(key: String, value: Double)] {
        let results: [(String, Double)]
        if searchText.isEmpty {
            results = Array(exchangeRatesViewModel.exchangeRates)
        } else {
            results = exchangeRatesViewModel.exchangeRates.filter { pair in
                pair.key.contains(searchText.uppercased())
            }
        }
        
        return results.sorted { (pair1: (key: String, value: Double), pair2: (key: String, value: Double)) -> Bool in
            return pair1.key < pair2.key
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

struct CurrencyRateView: View {
    var currency: String
    var rate: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack{
                Text(getFlag(currency: currency)).font(.largeTitle)
                Spacer()
                Text(String(format: "%.2f", rate))
                Text(currency).font(.caption).foregroundStyle(.gray)
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .overlay{
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray.opacity(0.24),lineWidth:1)
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

