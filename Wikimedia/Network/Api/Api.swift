//
//  Api.swift
//  Wikimedia
//
//  Created by Abhishek on 08/01/24.
//

import Foundation
//import Alamofire

class Api {
    var networkManager: URLSessionNetworkManager
    
    init(networkManager: URLSessionNetworkManager = URLSessionNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func buildHeaders(additionalHeaders: [String: String]?) -> [String:String] {
        var headers = [String:String]()
//        headers["cache-control"] = "no-cache"
//        headers["Accept-Encoding"] = "gzip"
//        headers["version_code"] = "25"
//        headers["client_type"] = "ios"
          headers["Content-Type"] = "application/json"
//        var alamoFireHeaders = Alamofire.HTTPHeaders(headers)
//
        if let additionalHeaders = additionalHeaders {
            for header in additionalHeaders {
                let key = header.key
                let value = header.value
                headers[key] = value
            }
        }

        return headers
    }
    
}
