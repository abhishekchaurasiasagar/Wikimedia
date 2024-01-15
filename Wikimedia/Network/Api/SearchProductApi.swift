//
//  SearchProductApi.swift
//  Wikimedia
//
//  Created by Abhishek on 11/01/24.
//

import Foundation

protocol SearchProductApi{
    func searchResult(searchString: String) async throws -> CategaryProduct
}

class SearchProductApiImpl: Api, SearchProductApi {
    func searchResult(searchString: String) async throws -> CategaryProduct {
        let url = "\(AppController.shared.getBaseURL)products/search?q=\(searchString)"
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        do {
            return try await self.networkManager.performOperation(
                urlString: url,
                method: .get,
                parameters: nil,
                response: CategaryProduct.self,
                headers: headers)
        } catch  {
            throw error
        }
    }
    
}

