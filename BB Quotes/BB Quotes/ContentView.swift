//
//  ContentView.swift
//  BB Quotes
//
//  Created by Joel Espinal on 9/6/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FetchView(show: Constants.bbName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bbName, systemImage: "tortoise")
                }
                
            FetchView(show: Constants.bcsName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bcsName, systemImage: "briefcase")
                }
            
            FetchView(show: Constants.eName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.eName, systemImage: "car")
                }
            
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.eName, systemImage: "car")
                }
            
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}

