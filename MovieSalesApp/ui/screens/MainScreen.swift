//
//  ContentView.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import SwiftUI

struct MainScreen: View {
    
    var body: some View {
        TabView {
                    // 1. Tab: Anasayfa
                    HomeScreen()
                        .tabItem {
                            Label("Anasayfa", systemImage: "house.fill")
                        }
                    
                    // 2. Tab: Favoriler
                    FavoritesScreen()
                        .tabItem {
                            Label("Favoriler", systemImage: "heart.fill")
                        }
                    
                    // 3. Tab: Sepet
                    CartScreen()
                        .tabItem {
                            Label("Sepet", systemImage: "cart.fill")
                        }
                }
        
    }
        
}

#Preview {
    MainScreen()
}
