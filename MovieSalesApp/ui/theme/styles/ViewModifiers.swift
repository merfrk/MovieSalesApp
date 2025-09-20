//
//  ViewModifiers.swift
//  MovieSalesApp
//
//  Created by Omer on 21.09.2025.
//

import Foundation
import SwiftUI


struct BodyFontModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            
            .font(.custom("NunitoSans-12ptExtraLight_Regular", size: 17))

            .lineSpacing(5)
    }
}


extension View {
    func bodyFont() -> some View {
        self.modifier(BodyFontModifier())
    }
}
