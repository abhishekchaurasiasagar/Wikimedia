//
//  ApiProvider.swift
//  Wikimedia
//
//  Created by Abhishek on 08/01/24.
//

protocol ApiProvider {
    var productApi: ProductApi { get }
}

class ApiProviderImpl: ApiProvider {
    static var instance = ApiProviderImpl()
    
    private init() {
        //
    }
    
    var productApi: ProductApi {
        return ProductApiImpl()
    }
}
