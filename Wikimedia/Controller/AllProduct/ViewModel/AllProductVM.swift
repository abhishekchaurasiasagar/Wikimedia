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
    
    func getHomeAPIDtails(skip:Int){
        ApiProviderImpl.instance.allCategaryProductApi.getLimitedProduct(limit: 10, skip: skip) { product, error in
            if error == nil{
                if let product = product{
                    self.allProduct.append(contentsOf: product.products)
                    self.totalItem = product.total
                    print(self.allProduct)
                }
            }else{
                print("Error \(String(describing: error))")
            }
        }
    }
}
