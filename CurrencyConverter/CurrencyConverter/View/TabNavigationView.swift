//
//  TabNavigationView.swift
//  CurrencyConverter
//
//  Created by Nick Theodoridis on 26/8/23.
//

import SwiftUI

struct TabNavigationView: View {
    
    @AppStorage("selectedOption") private var selectedOption = ""
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    
    
    var body: some View {
        TabView{
            ExchangesView()
                .tabItem(){
                    Image(systemName: "globe")
                    Text("Exchanges")
                }
            SettingsView(selectedOption: $selectedOption)
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
