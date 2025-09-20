//
//  CartScreen.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import SwiftUI

struct CartScreen: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    
    private let imageBaseUrl = "http://kasimadalan.pe.hu/movies/images/"
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if cartViewModel.cartItems.isEmpty {
                    Spacer()
                    Image(systemName: "cart.fill")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("Sepetiniz henüz boş.")
                        .bodyFont()
                        .padding(.top)
                    Spacer()
                } else {
                    
                    List {
                        ForEach(cartViewModel.cartItems) { item in
                            
                            HStack(spacing: 16) {
                                AsyncImage(url: URL(string: "\(imageBaseUrl)\(item.image)")) { image in
                                    image.resizable().aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 80, height: 120)
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text("Adet: \(item.orderAmount)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("\(item.price * item.orderAmount) TL")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                }
                                
                                Spacer()
                                Button {
                                    
                                    Task{
                                        await cartViewModel.deleteFromCart(cartItem: item)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .font(.title3)
                                }
                                .buttonStyle(.borderless)
                            }
                            .padding(.vertical, 8)
                        }
                        
                        
                    }
                    .listStyle(.plain)
                    
                    VStack(spacing: 16) {
                        HStack {
                            Text("Toplam:")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("\(cartViewModel.totalPrice) TL")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        
                        Button {
                            
                            print("Ödeme işlemi başlatıldı.")
                        } label: {
                            Text("Ödemeye Geç")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(AppColors.primary))
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(.thinMaterial)
                }
            }
            .navigationTitle("Sepetim")
            .task {
                
                await cartViewModel.loadCart()
            }
        }
    }
}



#Preview() {
    CartScreen()
        .environmentObject(CartViewModel())
}
