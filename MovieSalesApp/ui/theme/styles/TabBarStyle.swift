//
//  TabBarStyle.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import Foundation
import SwiftUI

struct TabBarStyle {
    static func setupTabBar() {
        let appearance = UITabBarAppearance()
        
        
        appearance.backgroundColor = UIColor(AppColors.beige)
        
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(AppColors.main)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(AppColors.main)]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
