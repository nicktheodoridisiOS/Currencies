//
//  TabNavigationView.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 26/8/23.
//

import SwiftUI

struct TabNavigationView: View {
    var body: some View {
        TabView{
            CurrencyListView()
                .tabItem(){
                    Image(systemName: "list.dash")
                    Text("Currency List")
                }
            CurrencyConverterView()
                .tabItem(){
                    Image(systemName: "dollarsign")
                    Text("Converter")
                }
        }
        .tint(.green)
    }
}

struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView()
    }
}
