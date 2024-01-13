//
//  NetworkManager.swift
//  Wikimedia
//
//  Created by Abhishek on 11/01/24.
//

import Foundation

typealias ResultHandler<T> = (Result<T, DataError>) -> Void

public enum NetworkEnvironment {
    case production
    case staging
    case uat
}

enum HTTPMethods: String{
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
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
