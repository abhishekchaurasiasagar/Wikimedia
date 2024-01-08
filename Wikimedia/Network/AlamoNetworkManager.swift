//
//  AlamoNetworkManager.swift
//  Wikimedia
//
//  Created by Abhishek on 08/01/24.
//

import Foundation
import Alamofire

class AlamoNetworkManager {
    func request<T: Codable>(urlString: String,
                             method: Alamofire.HTTPMethod,
                             parameters: [String: Any],
                             headers: Alamofire.HTTPHeaders,
                             encoding: Alamofire.ParameterEncoding = URLEncoding.default,
                             completion: @escaping (T?, AFError?) -> Void) {
        AF.request(urlString,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let result):
                completion(result, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }.validate(statusCode: 200..<299)
    }
}
