//
//  AlamoNetworkManager.swift
//  Wikimedia
//
//  Created by Abhishek on 08/01/24.
//

import Foundation

//class AlamoNetworkManager {
//    func request<T: Codable>(urlString: String,
//                             method: Alamofire.HTTPMethod,
//                             parameters: [String: Any],
//                             headers: Alamofire.HTTPHeaders,
//                             encoding: Alamofire.ParameterEncoding = URLEncoding.default,
//                             completion: @escaping (T?, AFError?) -> Void) {
//        AF.request(urlString,
//                   method: method,
//                   parameters: parameters,
//                   encoding: encoding,
//                   headers: headers).responseDecodable(of: T.self) { response in
//            switch response.result {
//            case .success(let result):
//                completion(result, nil)
//            case .failure(let error):
//                completion(nil, error)
//            }
//        }.validate(statusCode: 200..<299)
//    }
//}

typealias ResultHandler<T> = (Result<T, DataError>) -> Void

class URLSessionNetworkManager{
    func request<T: Decodable>(urlString: String,
                               method: HTTPMethods,
                               parameters: [String: Any]?,
                               headers: [String: String],
                               complition: @escaping ResultHandler<T>
    ){
        
        guard let url = URL(string: urlString) else{
            complition(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        
        if method != .get{
            if let param = parameters{
                request.httpBody = try? JSONSerialization.data(withJSONObject: param)
            }
        }
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else{
                complition(.failure(.invalidResponse))
                return
            }
            
            guard let data, error == nil else{
                complition(.failure(.invalidData))
                return
            }
            
            do{
                let user = try JSONDecoder().decode(T.self, from: data)
                complition(.success(user))
            }catch{
                complition(.failure(.decoding(error)))
            }
        }.resume()
    }
    
    
    func performOperation<T: Codable>(urlString: String,
                                      method: HTTPMethods,
                                      parameters: [String: Any]?,
                                      response: T.Type,
                                      headers: [String: String]) async throws -> T{
        
        guard let url = URL(string: urlString) else{
            throw HttpError.invalidURL
        }
        var request = URLRequest(url: url)
        
        if method != .get{
            if let param = parameters{
                request.httpBody = try? JSONSerialization.data(withJSONObject: param)
            }
        }
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        do {
            let (serverData,serverURLResponse) = try await URLSession.shared.data(for: request)
            
            guard let httpStausCode = serverURLResponse as? HTTPURLResponse,
                  200...299 ~= httpStausCode.statusCode else{
                throw HttpError.invalidData
            }
            
            return try JSONDecoder().decode(response.self, from: serverData)
        } catch {
            throw error
        }
        
    }
}

enum HttpError : Error {
    case jsonDecoding
    case noData
    case nonSuccessStatusCode
    case serverError
    case emptyCollection
    case emptyObject
    
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
}
