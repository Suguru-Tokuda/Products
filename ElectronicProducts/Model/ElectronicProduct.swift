//
//  ElectronicProduct.swift
//  ElectronicProducts
//
//  Created by Suguru Tokuda on 11/21/23.
//

import Foundation

struct ElectronicProduct: Decodable, Identifiable {
    let title, description, brand, category, thumbnail: String
    let images: [String]
    let id, price, stock: Int
    let discountPercentage, rating: Double
    
    var priceAfterDiscount: Double {
        return Double(price) - Double(price) * discountPercentage / 100
    }
    
    init(id: Int, title: String, description: String, brand: String, category: String, thumbnail: String, images: [String], price: Int, stock: Int, discountPercentage: Double, rating: Double) {
        self.id = id
        self.title = title
        self.description = description
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
        self.price = price
        self.stock = stock
        self.discountPercentage = discountPercentage
        self.rating = rating
    }
    
    init?(entity from: ElectronicProductEntity) {
        if let title = from.title,
           let description = from.productDesc,
           let brand = from.brand,
           let category = from.category,
           let thumbnail = from.thumbnail,
           let images = from.images {
            self.id = Int(from.id)
            self.title = title
            self.description = description
            self.brand = brand
            self.category = category
            self.thumbnail = thumbnail
            self.images = images.map { $0 as! String }
            self.price = Int(from.price)
            self.stock = Int(from.stock)
            self.discountPercentage = Double(from.discountPercentage)
            self.rating = Double(from.rating)
        } else {
            return nil
        }
    }
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case description
        case brand
        case category
        case thumbnail
        case images
        case price
        case stock
        case discountPercentage
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.brand = try container.decode(String.self, forKey: .brand)
        self.category = try container.decode(String.self, forKey: .category)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.images = try container.decode([String].self, forKey: .images)
        self.price = try container.decode(Int.self, forKey: .price)
        self.stock = try container.decode(Int.self, forKey: .stock)
        self.discountPercentage = try container.decode(Double.self, forKey: .discountPercentage)
        self.rating = try container.decode(Double.self, forKey: .rating)
    }
}
