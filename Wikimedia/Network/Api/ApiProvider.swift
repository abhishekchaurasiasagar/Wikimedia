//
//  ApiProvider.swift
//  Wikimedia
//
//  Created by Abhishek on 08/01/24.
//

protocol ApiProvider {
    var productApi: ProductApi { get }
    var allCategaryProductApi : AllCategaryProductApi {get}
    var searchProductApi : SearchProductApi{get}
    var addToCartApi: AddToCartApi{get}
    var addProductApi: AddProductApi{get}
}

class ApiProviderImpl: ApiProvider {
   
    static var instance = ApiProviderImpl()
    
    private init() {}
    
    var productApi: ProductApi {
        return ProductApiImpl()
    }
    
    var allCategaryProductApi: AllCategaryProductApi{
        return AllCategaryProductApiImpl()
    }
    
    var searchProductApi: SearchProductApi{
        return SearchProductApiImpl()
    }
    
    var addToCartApi: AddToCartApi{
        return AddToCartApiImpl()
    }
    
    var addProductApi: AddProductApi{
        return AddProductApiImpl()
    }
}

