//
//  AllCategaryProductApi.swift
//  Wikimedia
//
//  Created by Abhishek on 10/01/24.
//

import Foundation

protocol AllCategaryProductApi {
    func getAllProductCategories(completion: @escaping (CategaryProduct?, Error?) -> Void)
    func getLimitedProduct(limit: Int, skip: Int,completion: @escaping(CategaryProduct?,Error?) -> Void)
}

class AllCategaryProductApiImpl: Api, AllCategaryProductApi {
    func getLimitedProduct(limit: Int, skip: Int,completion: @escaping (CategaryProduct?, Error?) -> Void) {
        let url = "https://dummyjson.com/products?limit=\(limit)&skip=\(skip)&select="
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
    
    let allProductsUrl = "https://dummyjson.com/products"

    func getAllProductCategories(completion: @escaping (CategaryProduct?, Error?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.allProductsUrl,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
}
