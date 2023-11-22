//
//  ElectronicProductResponse.swift
//  ElectronicProducts
//
//  Created by Suguru Tokuda on 11/21/23.
//

import Foundation

struct ElectronicProductResponse: Decodable {
    let total, skip, limit: Int
    let products: [ElectronicProduct]
}
