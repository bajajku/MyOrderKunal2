//
//  HomeView.swift
//  MyOrderKunal2
//
//  Created by Kunal Bajaj on 2024-10-15.
//
//Kunal Bajaj 991648986

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView{
            OrderView()
                .tabItem{
                    Text("Home")
                    Image(systemName: "house")
                }
            
            ShowOrderView()
                .tabItem{
                    Text("Show Orders")
                    Image(systemName: "arrow.2.circlepath")}
        }
    }
}

#Preview {
    HomeView()
}
