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
    }
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .tint(Color(AppColors.text)) 
        }
    }
}
