//
//  ContentView.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import SwiftUI

struct MainScreen: View {
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    var body: some View {
        TabView {
                    HomeScreen()
                        .tabItem {
                            Label("Anasayfa", systemImage: "house.fill")
                        }
                    
                    FavoritesScreen()
                        .tabItem {
                            Label("Favoriler", systemImage: "heart.fill")
                        }
                    
                    CartScreen()
                        .tabItem {
                            Label("Sepet", systemImage: "cart.fill")
                        }
                }
        .environmentObject(cartViewModel)
        .environmentObject(favoritesViewModel)
        .environmentObject(homeViewModel)
    }
        
}

#Preview {
    MainScreen()
}
