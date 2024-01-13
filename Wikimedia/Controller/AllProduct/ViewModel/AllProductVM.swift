//
//  AllProductVM.swift
//  Wikimedia
//
//  Created by Abhishek on 11/01/24.
//

import Foundation

class AllProductVM{
    
    var allProduct: [Brand] = []
    var totalItem = 0
    var eventHandler: ((_ event: Event) -> Void)?
    
    func getHomeAPIDtails(skip:Int){
        eventHandler?(.loading)
        ApiProviderImpl.instance.allCategaryProductApi.getLimitedProduct(limit: 10, skip: skip) { response in
            switch response{
            case .success(let product):
                self.allProduct.append(contentsOf: product.products)
                self.totalItem = product.total
                self.eventHandler?(.dataLoaded)
                break
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
            self.eventHandler?(.stopLoading)
        }
    }
}
