//
//  AllCategaryProductApi.swift
//  Wikimedia
//
//  Created by Abhishek on 10/01/24.
//

import Foundation

protocol AllCategaryProductApi {
    func getAllProductCategories(completion: @escaping (CategaryProduct?, Error?) -> Void)
}

class AllCategaryProductApiImpl: Api, AllCategaryProductApi {
    
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
