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

//class URLSessionNetworkManager {
//    func request<T: Decodable>(urlString: String,
//                               method: NetworkType,
//                               parameters: [String: Any],
//                               headers: [String: String],
//                               completion: @escaping (T?, Error?) -> Void) {
//        
//        guard let url = URL(string: urlString) else {
//            completion(nil, NSError(domain: "InvalidURL", code: -1, userInfo: nil))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//        request.allHTTPHeaderFields = headers
//        
//        if method.rawValue == "GET" {
//            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
//            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
//            request.url = components.url
//        } else {
//            // Assuming JSON encoding for non-GET requests
//            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        }
//        
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                DispatchQueue.main.async {
//                    
//                    guard let data else {
//                        completion(nil, error)
//                        return
//                    }
//                    guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
//                        completion(nil,error)
//                        return
//                    }
//                    
//                    // JSONDecoder() converts data to model of type Array
//                    do {
//                        let response = try JSONDecoder().decode(T.self, from: data)
//                        completion(response,nil)
//                    }
//                    catch {
//                        completion(nil,error)
//                    }
//                }
//        }.resume()
//    }
//}

typealias ResultHandler<T> = (Result<T, DataError>) -> Void

class URLSessionNetworkManager{
    func request<T: Decodable>(urlString: String,
                               method: NetworkType,
                               parameters: [String: Any]?,
                               headers: [String: String],
        complition: @escaping ResultHandler<T>
    ){
//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        guard let userURL = URL(string: urlString) else{
            complition(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: userURL)
        
        if let param = parameters{
            request.httpBody = try? JSONSerialization.data(withJSONObject: param)
        }
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
            URLSession.shared.dataTask(with: userURL) { data, response, error in
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
    }


enum HTTPMethods: String{
    case get  = "GET"
}

protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
}

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
}


enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
}
