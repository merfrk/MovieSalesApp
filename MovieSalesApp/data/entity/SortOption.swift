//
//  SortOption.swift
//  MovieSalesApp
//
//  Created by Omer on 21.09.2025.
//

import Foundation
enum SortOption: String, CaseIterable, Identifiable {
    case name = "Ada Göre (A-Z)"
    case priceAsc = "Fiyata Göre (Artan)"
    case priceDesc = "Fiyata Göre (Azalan)"
    case ratingDesc = "Puana Göre (Yüksekten Düşüğe)"

    
    var id: String { self.rawValue }
}
