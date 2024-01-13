//
//  AllCategaryProductApi.swift
//  Wikimedia
//
//  Created by Abhishek on 10/01/24.
//

import Foundation

protocol AllCategaryProductApi {
    func getAllProductCategories(completion: @escaping (ResultHandler<CategaryProduct>))
    func getLimitedProduct(limit: Int, skip: Int,completion: @escaping(ResultHandler<CategaryProduct>))
}

class AllCategaryProductApiImpl: Api, AllCategaryProductApi {
    
    //MARK: %d for Integer
    let limiturl = "\(AppController.shared.getBaseURL)products?limit=%d&skip=%d&select="
    let allProductsUrl = "\(AppController.shared.getBaseURL)products"
    
    func getLimitedProduct(limit: Int, skip: Int,completion: @escaping (ResultHandler<CategaryProduct>)) {
      
        let headers = self.buildHeaders(additionalHeaders: nil)
        let url = String(format: limiturl, limit,skip)
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    complition: completion)
    }
    
    func getAllProductCategories(completion: @escaping (ResultHandler<CategaryProduct>)) {
        
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: allProductsUrl,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    complition: completion)
    }
    
}
