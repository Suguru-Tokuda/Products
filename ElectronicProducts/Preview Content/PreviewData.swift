//
//  PreviewData.swift
//  ElectronicProducts
//
//  Created by Suguru Tokuda on 11/21/23.
//

import Foundation

struct PreviewData {
    static let products: [ElectronicProduct] = [
        ElectronicProduct(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", brand: "Apple", category: "smartphones", thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg", images: [
            "https://i.dummyjson.com/data/products/1/1.jpg",
            "https://i.dummyjson.com/data/products/1/2.jpg",
            "https://i.dummyjson.com/data/products/1/3.jpg",
            "https://i.dummyjson.com/data/products/1/4.jpg",
            "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
        ], price: 549, stock: 94, discountPercentage: 12.96, rating: 4.69),
        ElectronicProduct(id: 2, title: "iPhone X", description: "SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ...", brand: "Apple", category: "smartphones", thumbnail: "https://i.dummyjson.com/data/products/2/thumbnail.jpg", images: ["https://i.dummyjson.com/data/products/2/1.jpg", "https://i.dummyjson.com/data/products/2/2.jpg", "https://i.dummyjson.com/data/products/2/3.jpg", "https://i.dummyjson.com/data/products/2/thumbnail.jpg"], price: 899, stock: 34, discountPercentage: 17.94, rating: 4.44)
    ]
}
