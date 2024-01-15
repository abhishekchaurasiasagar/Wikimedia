//
//  SearchProductVM.swift
//  Wikimedia
//
//  Created by Abhishek on 15/01/24.
//

import Foundation

class SearchProductVM{
    var allSearchProduct = [Brand]()
    var eventHandler: ((_ event: Event) -> Void)?
    
    func searchProduct(searchText: String){
        allSearchProduct = []
        Task{
            do{
                eventHandler?(.loading)
                let result = try await ApiProviderImpl.instance.searchProductApi.searchResult(searchString: searchText)
                allSearchProduct.append(contentsOf: result.products)
                eventHandler?(.dataLoaded)
            } catch let serviceError{
                print(serviceError)
                throw serviceError
            }
            eventHandler?(.stopLoading)
        }
    }
}
