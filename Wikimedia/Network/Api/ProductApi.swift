//
//  ProductApi.swift
//  Wikimedia
//
//  Created by Abhishek on 08/01/24.
//

import Foundation

protocol ProductApi {
    func getAllProductCategories(completion: @escaping (Product?, Error?) -> Void)
}

class ProductApiImpl: Api, ProductApi {
    
    let allProductsUrl = """
https://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch=apple&gsrlimit=10&prop=pageimages|extracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max
"""

    func getAllProductCategories(completion: @escaping (Product?, Error?) -> Void) {
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: self.allProductsUrl,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    completion: completion)
    }
    
}
