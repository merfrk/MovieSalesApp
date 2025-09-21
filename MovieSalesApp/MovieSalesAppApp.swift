//
//  MovieSalesAppApp.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import SwiftUI

@main
struct MovieSalesAppApp: App {
    init(){
        NavigationBarStyle.setupNavigationBar()
        TabBarStyle.setupTabBar()
        configureURLCache()
    }
    var body: some Scene {
        WindowGroup {
            MainScreen()
        }
    }
    private func configureURLCache() {

            let memoryCapacity = 50 * 1024 * 1024 // 50 MB
            let diskCapacity = 250 * 1024 * 1024 // 250 MB
            
            let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "movieImages")
            

            URLCache.shared = cache
            
            print("URLCache başarıyla yapılandırıldı.")
        }
}
