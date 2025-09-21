//
//  AnimationView.swift
//  MovieSalesApp
//
//  Created by Omer on 21.09.2025.
//
import DotLottie
import SwiftUI

struct AnimationView: View {
    let fileName: String
        let isLooping: Bool
    
    init(fileName: String, isLooping: Bool = false) {
            self.fileName = fileName
            self.isLooping = isLooping
        }
    var body: some View {
        
        DotLottieAnimation(fileName: fileName, config: AnimationConfig(autoplay: true, loop: isLooping)).view()
           
    }
}

#Preview {
    AnimationView(fileName: "success")
}
