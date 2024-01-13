//
//  AddToCartApi.swift
//  Wikimedia
//
//  Created by Abhishek on 11/01/24.
//

import Foundation

protocol AddToCartApi{
    func getSaveCartProduct(productID: Int,completion: @escaping (ResultHandler<Brand>))
}

class AddToCartApiImpl: Api,AddToCartApi {
    func getSaveCartProduct(productID: Int, completion: @escaping (ResultHandler<Brand>)) {
        let url = "\(AppController.shared.getBaseURL)products/\(productID)"
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    complition: completion)
    }
}
