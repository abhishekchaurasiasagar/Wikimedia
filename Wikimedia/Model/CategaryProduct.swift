//
//  CategaryProduct.swift
//  Wikimedia
//
//  Created by Abhishek on 10/01/24.
//

import Foundation

// MARK: - CategaryProduct
struct CategaryProduct: Codable {
    let products: [Brand]
    let total, skip, limit: Int
}

// MARK: - Product
struct Brand: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
