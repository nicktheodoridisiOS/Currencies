//
//  TabNavigationView.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 26/8/23.
//

import SwiftUI

struct TabNavigationView: View {
    
    @AppStorage("selectedOption") private var selectedOption = ""
    
    
    var body: some View {
        TabView{
            CurrencyListView()
                .tabItem(){
                    Image(systemName: "list.dash")
                    Text("List")
                }
            ConverterView(selectedOption: $selectedOption)
                .tabItem(){
                    Image(systemName: "dollarsign")
                    Text("Converter")
                }
            SettingsView(selectedOption: $selectedOption)
                .tabItem(){
                    Image(systemName: "gear")
                    Text("Settings")
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
