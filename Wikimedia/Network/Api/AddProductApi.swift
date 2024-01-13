//
//  AddProductApi.swift
//  Wikimedia
//
//  Created by Abhishek on 13/01/24.
//

import Foundation

protocol AddProductApi{
    func addNewProduct(completion: @escaping ResultHandler<AddProductModel>)
}

class AddProductApiImpl: Api,AddProductApi{
    
    let addProductURL = "\(AppController.shared.getBaseURL)products/add"
    
    func addNewProduct(completion: @escaping ResultHandler<AddProductModel>) {
        let url = addProductURL
        
        let param = ["title" : "BMW"]
        
        let header = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(
                            urlString: url,
                            method: .post,
                            parameters: param,
                            headers: header,
                            complition: completion
                        )
    }
}
