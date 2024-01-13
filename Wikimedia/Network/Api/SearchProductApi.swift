//
//  SearchProductApi.swift
//  Wikimedia
//
//  Created by Abhishek on 11/01/24.
//

import Foundation

protocol SearchProductApi{
    func searchResult(searchString: String,completion: @escaping (ResultHandler<CategaryProduct>))
}

class SearchProductApiImpl: Api, SearchProductApi {
    func searchResult(searchString: String,completion: @escaping (ResultHandler<CategaryProduct>)) {
        let url = "\(AppController.shared.getBaseURL)products/search?q=\(searchString)"
        let headers = self.buildHeaders(additionalHeaders: nil)
        
        self.networkManager.request(urlString: url,
                                    method: .get,
                                    parameters: [:],
                                    headers: headers,
                                    complition: completion)
    }
}
