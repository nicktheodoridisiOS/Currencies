//
//  CurrencyConverterGenerator.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 26/8/23.
//

import SwiftUI

struct CurrencyListView: View {
    
    @StateObject var viewModel = FetchData()
    @State private var searchText: String = ""
    
    @State private var scaleAmount: CGFloat = 0
    @State var isSorted: Bool = false
    
    
    var filteredConvertionData: [Currency] {
        guard !searchText.isEmpty else{
            return viewModel.convertionData.sorted(by: {$0.currencyName < $1.currencyName})
            
        }
        return viewModel.convertionData.filter {$0.currencyName.localizedStandardContains(searchText)}
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        NavigationStack{
            GeometryReader { geometry in
                VStack(alignment: .center){
                    if viewModel.convertionData.isEmpty{
                        VStack{
                            HStack(){
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                            .padding(.top)
                            Spacer()
                            
                        }
                    }
                    else{
                        ScrollView(showsIndicators: false){
                            VStack{
                                HStack{
                                    Menu(content: {
                                        ForEach(currencies, id: \.self){ name in
                                            Button {
                                                viewModel.updateData(base: name)
                                                
                                            } label: {
                                                Text("\(getFlag(currency:name)) \(name)")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.primary)
                                            }
                                            
                                        }
                                        
                                    }){
                                        
                                        Text("\(getFlag(currency:viewModel.base)) \(viewModel.base)")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.primary)
                                            .background{
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: 110,height: 40)
                                                    .foregroundColor(.secondary.opacity(0.1))
                                            }
                                        
                                        
                                    }
                                    Spacer()
                                }
                            }
                            .padding(.top,10)
                            .padding(.horizontal,40)
                            
                            LazyVGrid(columns: columns){
                                
                                ForEach(filteredConvertionData){ rate in
                                    VStack(spacing:5){
                                        Text(getFlag(currency:rate.currencyName))
                                            .font(.largeTitle)
                                        VStack(alignment: .center){
                                            Text(rate.currencyName)
                                                .fontWeight(.bold)
                                            Text("\(rate.currencyValue,specifier: "%.2f")")
                                                .font(.caption)
                                        }
                                    }
                                    .background{
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color.gray.opacity(0.1))
                                            .frame(width: geometry.size.width/3 - 20, height: geometry.size.width/3 - 20 )
                                    }
                                    .scaleEffect(1)
                                    .onAppear{
                                        withAnimation(.spring()){
                                            scaleAmount = 1
                                        }
                                    }
                                    
                                }
                                .padding(.top,30)
                                
                            }
                            .padding(.horizontal)
                            
                            
                        }
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle("Currency List")
            }
        }
        .tint(Color.green)
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

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
    }
}
