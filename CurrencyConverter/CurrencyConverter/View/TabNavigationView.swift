//
//  TabNavigationView.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 26/8/23.
//

import SwiftUI

struct TabNavigationView: View {
    
    @AppStorage("selectedCurrencyBase") var selectedCurrencyCode: String = "EUR"
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    
    
    var body: some View {
        TabView{
            ExchangesView()
                .tabItem(){
                    Image(systemName: "arrow.2.circlepath")
                    Text("Exchanges")
                }
            ConverterView()
                .tabItem(){
                    Image(systemName: "arrow.right.arrow.left.circle")
                    Text("Converter")
                }
            SettingsView()
                .tabItem(){
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .tint(.green)
        .environment(\.colorScheme, isDarkModeEnabled ? .dark : .light)

    }
}

struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView()
    }
}
