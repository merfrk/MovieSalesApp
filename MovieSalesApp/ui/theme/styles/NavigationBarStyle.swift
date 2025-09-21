//
//  NavigationBarStyle.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import Foundation
import SwiftUI

struct NavigationBarStyle{
    static func setupNavigationBar(){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(AppColors.main)
        let titleFont = UIFont(name: "NunitoSans-12ptExtraLight_Regular", size: 22) ?? UIFont.systemFont(ofSize: 22)
        let largeTitleFont = UIFont(name: "NunitoSans-12ptExtraLight_Regular", size: 32) ?? UIFont.systemFont(ofSize: 32)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(AppColors.text),
            .font: titleFont
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(AppColors.text),
            .font: largeTitleFont
        ]
        
        
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
