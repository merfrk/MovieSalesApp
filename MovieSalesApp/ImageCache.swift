//
//  ImageCache.swift
//  MovieSalesApp
//
//  Created by Omer on 21.09.2025.
//

import Foundation
import UIKit


class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache = NSCache<NSURL, UIImage>()
    
    
    func get(forKey key: URL) -> UIImage? {
        return cache.object(forKey: key as NSURL)
    }
    
    
    func set(forKey key: URL, image: UIImage) {
        cache.setObject(image, forKey: key as NSURL)
    }
}
