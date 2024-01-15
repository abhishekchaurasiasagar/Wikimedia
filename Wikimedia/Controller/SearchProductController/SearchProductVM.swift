//
//  SearchProductVM.swift
//  Wikimedia
//
//  Created by Abhishek on 15/01/24.
//

import Foundation

class SearchProductVM{
    
    func searchProduct(){
        Task{
            do{
                let result = try await ApiProviderImpl.instance.searchProductApi.searchResult(searchString: "i")
                dump(result)
            } catch let serviceError{
                print(serviceError)
                throw serviceError
            }
        }
    }
}
