//
//  CachedAsyncImage.swift
//  MovieSalesApp
//
//  Created by Omer on 21.09.2025.
//


import SwiftUI

struct CachedAsyncImage<Content: View, Placeholder: View>: View {
    private let url: URL?
    private let content: (Image) -> Content
    private let placeholder: () -> Placeholder
    
    @State private var image: UIImage?

    init(url: URL?, @ViewBuilder content: @escaping (Image) -> Content, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }

    var body: some View {
        if let uiImage = image {
            
            content(Image(uiImage: uiImage))
        } else {
            
            placeholder()
                .task {
                    await loadImage()
                }
        }
    }
    
    private func loadImage() async {
        guard let url = url else { return }
        
        
        if let cachedImage = ImageCache.shared.get(forKey: url) {
            self.image = cachedImage
            
            return
        }
        
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                
                ImageCache.shared.set(forKey: url, image: uiImage)
                self.image = uiImage
                
            }
        } catch {
            print("Resim indirilemedi: \(error.localizedDescription)")
        }
    }
}
