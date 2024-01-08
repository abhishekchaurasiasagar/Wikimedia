//
//  Product.swift
//  Wikimedia
//
//  Created by Abhishek on 08/01/24.
//

import Foundation

struct Product: Codable {
    let batchcomplete: String
    let welcomeContinue: Continue
    let query: Query
    let limits: Limits

    enum CodingKeys: String, CodingKey {
        case batchcomplete
        case welcomeContinue = "continue"
        case query, limits
    }
}

// MARK: - Limits
struct Limits: Codable {
    let pageimages, extracts: Int
}

// MARK: - Query
struct Query: Codable {
    let pages: [String: Page]
}

// MARK: - Page
struct Page: Codable {
    let pageid, ns: Int
    let title: String
    let index: Int
    let thumbnail: Thumbnail?
    let pageimage: String?
    let extract: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let source: String
    let width, height: Int
}

// MARK: - Continue
struct Continue: Codable {
    let gsroffset: Int
    let continueContinue: String

    enum CodingKeys: String, CodingKey {
        case gsroffset
        case continueContinue = "continue"
    }
}

struct PageType{
    let title: String?
    let thumbnail: String?
    let extract: String?
}
